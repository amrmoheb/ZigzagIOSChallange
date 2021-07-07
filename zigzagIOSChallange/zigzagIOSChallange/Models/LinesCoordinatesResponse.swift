//
//  LinesCoordinatesResponse.swift
//  zigzagIOSChallange
//
//  Created by Mac on 7/7/21.
//

import Foundation
class LinesCoordinatesResponse: Codable {

    let transportations: [Transportation]?
    
 
}
class Transportation: Codable {

    let coords: [[[Double]]]?
}
