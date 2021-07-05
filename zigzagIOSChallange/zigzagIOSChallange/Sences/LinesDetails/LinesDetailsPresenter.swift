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
    
    

}
extension LinesDetailsPresenter: LinesDetailsInteractorOutput
{
    func present(LinesData: LinesDetails.Response) {
        FullLinesArray = LinesData.LinesList
        print("present interactor output in presenter")
        view?.display(reloadLinesList: Display.reloadList)
    }
    
   
    
    
}
extension LinesDetailsPresenter: LinesDetailsPresenterInput
{
    func handle() {
        print("handle view task in presenter")
        interactor.perform()
    }
    func GetLineNameByIndex(index : Int) -> String {
        
      return  FullLinesArray[index].stopEvent?.service?.originText?.text ?? ""
    }
    func GetLineCount() -> Int {
        
        return  FullLinesArray.count
    }
    
}
