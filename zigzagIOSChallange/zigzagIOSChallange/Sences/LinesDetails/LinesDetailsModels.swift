//
//  LinesDetailsModels.swift
//  zigzagIOSChallange
//
//  Created by Mac on 7/5/21.
//

import Foundation
enum  LinesDetails {
    struct Response {
        var LinesList = [StopEventResult]()
    }
    
}
enum Display{
    case reloadList
    struct Filters {
        var bus = false
        var ubahan = false
        var rbahan = false
        var sbahan = false
        
    }
}
enum Gleis: String
{
    case GL1 = "Gleis 1"
    case GL2 = "Gleis 2"

    case GL3 = "Gleis 3"

    case GL4 = "Gleis 4"

    case GL5 = "Gleis 5"
    case GL6 = "Gleis 6"
    case GL7 = "Gleis 7"


    
}
enum FiltersStates{
    case Bus
    case UBahan
    case RBahan
    case SBahan
}


