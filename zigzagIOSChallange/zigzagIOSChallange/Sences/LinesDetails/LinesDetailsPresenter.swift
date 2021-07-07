//
//  LinesDetailsPresenter.swift
//  zigzagIOSChallange
//
//  Created by Mac on 7/5/21.
//

import Foundation
import MapKit
class LinesDetailsPresenter {
    var interactor: LinesDetailsInteractorInput!
   weak var view : LinesDetailsPresenterOutput?
    var FullLinesArray = [StopEventResult]()
    var BusLinesArray = [StopEventResult]()
    var UBahanLinesArray = [StopEventResult]()
    var RBahanLinesArray = [StopEventResult]()
    var SBahanLinesArray = [StopEventResult]()
    var CurrentLinesArray = [StopEventResult]()
    
    
    var FullLinesCoordinates = [[[Double]]]()
    var BusFilterFlag = false
    var UBahanFilterFlag = false
    var RBahanFilterFlag = false
    var SBahanFilterFlag = false
    
    var stopRefPoint = ""
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
    func present(LinesCoordsData : TransportationLinesDetails.LinesCoordsResponse) {
        FullLinesCoordinates = LinesCoordsData.LinesCoordList
        view?.display(draw: Draw.Lines)
    }
    
    func present(LinesData: TransportationLinesDetails.Response) {
        FullLinesArray = LinesData.LinesList
        CurrentLinesArray = FullLinesArray
        FillLinesBasedOnCategory()
        print("present interactor output in presenter")
        var request = Perform.GetLineCoord()
        request.journeyRef = CurrentLinesArray[0].stopEvent?.service?.journeyRef ?? ""
        print(request.journeyRef)
        interactor.perform(LinesDetails: request)
        view?.display(reloadLinesList: Display.reloadList)
    }
    
   
    
    
}

extension LinesDetailsPresenter: LinesDetailsPresenterInput
{
    func setStopRefPoint(value: String) {
        stopRefPoint = value
    }
    
    func GetDrawableLineCoordsByIndex(index: Int) -> [CLLocationCoordinate2D] {
        var DrowableLineCoord = [CLLocationCoordinate2D]()
        for i in 0...FullLinesCoordinates[index].count-1 {
            var locationCoord = CLLocationCoordinate2D()
            locationCoord.latitude = FullLinesCoordinates[index][i][0]
            locationCoord.longitude = FullLinesCoordinates[index][i][1]
            DrowableLineCoord.append(locationCoord)
        }
        return DrowableLineCoord
    }
    
    func GetDrawableLinesCount() -> Int {
        return FullLinesCoordinates.count
    }
    
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
        var request = Perform.GetLineCoord()
        request.journeyRef = CurrentLinesArray[0].stopEvent?.service?.journeyRef ?? ""
        print(request.journeyRef)
        interactor.perform(LinesDetails: request)
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
        var request = Perform.GetLineDetails()
        request.StopPointRef = stopRefPoint
        interactor.perform(LinesDetails: request)
    }
    func GetLineNameByIndex(index : Int) -> String {
        
      return  CurrentLinesArray[index].stopEvent?.service?.originText?.text ?? ""
    }
    func GetLineCount() -> Int {
        
        return  CurrentLinesArray.count
    }
    
}
