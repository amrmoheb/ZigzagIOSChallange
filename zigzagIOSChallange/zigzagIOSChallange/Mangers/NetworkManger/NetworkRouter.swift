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
   

    func GetUrl() -> String {
        var relativePath = ""
        switch self {
     
        case .GetLinesData:
             relativePath = "http://efastatic.vvs.de/zigzag/trias"
          
        
        }
        return NetworkRouter.baseURLString + relativePath
    }
    func GetMethod() -> String {
        switch self {
        
        case .GetLinesData:
             return "XMLPost"
       
        }
    }
    func GetPostBodyInfo() -> String {
        switch self {
        
        case .GetLinesData( let stopPointRef):
             return stopPointRef
       
        }

    }

  
    
}
