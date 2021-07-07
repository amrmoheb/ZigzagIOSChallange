//
//  LinesDetailsProtocols.swift
//  zigzagIOSChallange
//
//  Created by Mac on 7/5/21.
//

import Foundation

protocol LinesDetailsPresenterInput {
    func handle()
    func GetLineNameByIndex(index : Int) -> String
    func GetArriveTimeByIndex(index : Int) -> String
    func GetEstimatedTimeByIndex(index : Int) -> String
    func GetGateByIndex(index : Int) -> String
    func GetPublishedLineNmaeByIndex(index : Int) -> String

    func GetLineCount() -> Int
    func FilterSelected (filterState : FiltersStates) 
}
protocol LinesDetailsPresenterOutput: class {
    func display(reloadLinesList : Display)
    func display(Filters : Display.Filters)

}
protocol LinesDetailsInteractorInput {
    func perform()
}
protocol LinesDetailsInteractorOutput: class {
    func present(LinesData : LinesDetails.Response)
}
