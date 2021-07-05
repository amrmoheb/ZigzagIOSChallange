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
    func GetLineCount() -> Int
}
protocol LinesDetailsPresenterOutput: class {
    func display(reloadLinesList : Display)
    
}
protocol LinesDetailsInteractorInput {
    func perform()
}
protocol LinesDetailsInteractorOutput: class {
    func present(LinesData : LinesDetails.Response)
}
