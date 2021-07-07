//
//  File.swift
//  MREC
//
//  Created by developer on 06/05/2020.
//  Copyright © 2020 developer. All rights reserved.
//

import Foundation

enum NetworkRouter
{  static let baseURLString = ""
    case GetLinesData(String)
   case GetLinesCoordinate(String)

    func GetUrl() -> String {
        var relativePath = ""
        switch self {
     
        case .GetLinesData:
             relativePath = "http://efastatic.vvs.de/zigzag/trias"
          
        
        case .GetLinesCoordinate(let journeyRef):
            //vvs:10001::H:j21:194
            relativePath = "https://www2.vvs.de/smarths/XML_GEOOBJECT_REQUEST?SpEncId=0&coordOutputFormat=EPSG:4326&line=\(journeyRef)&outputFormat=rapidJSON&serverInfo=1&spTZO=1&stFaZon=1&vSL=0&version=10.2.10.139"

        }
        return NetworkRouter.baseURLString + relativePath
    }
    func GetMethod() -> String {
        switch self {
        
        case .GetLinesData:
             return "XMLPost"
       
        case .GetLinesCoordinate:
            return "GET"
        }
    }
    func GetPostBodyInfo() -> String {
        switch self {
        
        case .GetLinesData( let stopPointRef):
             return stopPointRef
       
        case .GetLinesCoordinate:
           return ""
        }

    }

  
    
}
