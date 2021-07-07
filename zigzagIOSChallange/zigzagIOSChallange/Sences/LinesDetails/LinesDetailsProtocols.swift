//
//  LinesDetailsProtocols.swift
//  zigzagIOSChallange
//
//  Created by Mac on 7/5/21.
//

import Foundation
import  MapKit
protocol LinesDetailsPresenterInput {
    func handle()
    func GetLineNameByIndex(index : Int) -> String
    func GetArriveTimeByIndex(index : Int) -> String
    func GetEstimatedTimeByIndex(index : Int) -> String
    func GetGateByIndex(index : Int) -> String
    func GetPublishedLineNmaeByIndex(index : Int) -> String
    func GetDrawableLineCoordsByIndex(index : Int) -> [CLLocationCoordinate2D]
    func GetDrawableLinesCount() -> Int
    func GetLineCount() -> Int
    func FilterSelected (filterState : FiltersStates) 
}
protocol LinesDetailsPresenterOutput: class {
    func display(reloadLinesList : Display)
    func display(Filters : Display.Filters)
    func display(draw : Draw)


}
protocol LinesDetailsInteractorInput {
    func perform(LinesDetails : Perform.GetLineDetails)
    func perform(LinesDetails : Perform.GetLineCoord)

}
protocol LinesDetailsInteractorOutput: class {
    func present(LinesData : TransportationLinesDetails.Response)
    func present(LinesCoordsData : TransportationLinesDetails.LinesCoordsResponse)

}
