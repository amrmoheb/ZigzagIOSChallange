//
//  LinesDetailsPresenter.swift
//  zigzagIOSChallange
//
//  Created by Mac on 7/5/21.
//

import Foundation
class LinesDetailsPresenter {
    var interactor: LinesDetailsInteractorInput!
   weak var view : LinesDetailsPresenterOutput?
    var FullLinesArray = [StopEventResult]()
    var BusLinesArray = [StopEventResult]()
    var UBahanLinesArray = [StopEventResult]()
    var RBahanLinesArray = [StopEventResult]()
    var SBahanLinesArray = [StopEventResult]()
    var CurrentLinesArray = [StopEventResult]()
    
    var BusFilterFlag = false
    var UBahanFilterFlag = false
    var RBahanFilterFlag = false
    var SBahanFilterFlag = false
    func GetTimeFromDate(dateStr : String) -> String {
        let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let datetime  = dateFormatter.date(from: dateStr)
         {
        let calendar = Calendar.current // or e.g. Calendar(identifier: .persian)

        let hour = calendar.component(.hour, from: datetime)
        let minute = calendar.component(.minute, from: datetime)
        let second = calendar.component(.second, from: datetime)
            return String(hour) + ":" + String(minute)
        }else
        {
            return ""
        }
    }
    func GetGleisName(str : String)->String
    {
        switch str {
        case "Gleis 1":
            return "Gl 1"
        case "Gleis 2":
            return "Gl 2"
        case "Gleis 3":
            return "Gl 3"
        case "Gleis 4":
            return "Gl 4"
        case "Gleis 5":
            return "Gl 5"
        case "Gleis 6":
            return "Gl 6"
        case "Gleis 7":
            return "Gl 7"
        case "Gleis 8":
            return "Gl 8"
        default:
            return ""
        }

    }
    func FillLinesBasedOnCategory()  {
        var filters = Display.Filters()

        for item in FullLinesArray {
          //  item.stopEvent.
            if let TransportationCategory =  item.stopEvent?.service?.transportationMode?.name?.text
            {
                switch TransportationCategory {
                case "bus":
                    BusLinesArray.append(item)
                    filters.bus = true
                case "S-Bahn":
                    SBahanLinesArray.append(item)
                    filters.sbahan = true
                case "R-Bahn":
                    UBahanLinesArray.append(item)
                    filters.ubahan = true
                case "U-Bahn":
                    RBahanLinesArray.append(item)
                    filters.rbahan = true
                default:
                    print("category not found")
                }
            }
        }
        view?.display(Filters: filters)
    }
    
}
extension LinesDetailsPresenter: LinesDetailsInteractorOutput
{
    func present(LinesData: LinesDetails.Response) {
        FullLinesArray = LinesData.LinesList
        CurrentLinesArray = FullLinesArray
        FillLinesBasedOnCategory()
        print("present interactor output in presenter")
        view?.display(reloadLinesList: Display.reloadList)
    }
    
   
    
    
}
extension LinesDetailsPresenter: LinesDetailsPresenterInput
{
    func FilterSelected(filterState: FiltersStates) {
        switch filterState {
        case .Bus:
            CurrentLinesArray = BusLinesArray
        case .UBahan:
            CurrentLinesArray = UBahanLinesArray
        case .SBahan:
            CurrentLinesArray = SBahanLinesArray
        case .RBahan:
            CurrentLinesArray = RBahanLinesArray
        default:
            CurrentLinesArray = FullLinesArray
        }
        view?.display(reloadLinesList: Display.reloadList)
    }
    
    func GetPublishedLineNmaeByIndex(index: Int) -> String {
        return  CurrentLinesArray[index].stopEvent?.service?.publishedLineName?.text ?? ""

    }
    
    func GetArriveTimeByIndex(index: Int) -> String {
        if let dateString  = CurrentLinesArray[index].stopEvent?.thisCall?.callAtStop?.serviceDeparture?.timetabledTime
        {
            return GetTimeFromDate(dateStr: dateString)
        }
        else {
            return ""
        }
    }
    
    func GetEstimatedTimeByIndex(index: Int) -> String {
        
        if let dateString  = CurrentLinesArray[index].stopEvent?.thisCall?.callAtStop?.serviceDeparture?.estimatedTime
        {
            return GetTimeFromDate(dateStr: dateString)
        }
        else {
            return ""
        }

    }
    
    func GetGateByIndex(index: Int) -> String {
        return GetGleisName( str: CurrentLinesArray[index].stopEvent?.thisCall?.callAtStop?.plannedBay?.BayName ?? "")

    }
    
    func handle() {
        print("handle view task in presenter")
        interactor.perform()
    }
    func GetLineNameByIndex(index : Int) -> String {
        
      return  CurrentLinesArray[index].stopEvent?.service?.originText?.text ?? ""
    }
    func GetLineCount() -> Int {
        
        return  CurrentLinesArray.count
    }
    
}
