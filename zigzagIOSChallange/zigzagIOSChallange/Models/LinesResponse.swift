//
//  LinesResponse.swift
//  zigzagIOSChallange
//
//  Created by Mac on 7/5/21.
//

import Foundation
import  XMLMapper
class Routes: XMLMappable {
    var nodeName: String!

    var serviceDelevery: ServiceDelivery?
   

    required init?(map: XMLMap) {}

    func mapping(map: XMLMap) {
        serviceDelevery <- map["trias:ServiceDelivery"]
        
    }
}
class ServiceDelivery: XMLMappable {
    var nodeName: String!

    var deliveryPayload: DeliveryPayload?
   

    required init?(map: XMLMap) {}

    func mapping(map: XMLMap) {
        deliveryPayload <- map["trias:DeliveryPayload"]
        
    }
}
class DeliveryPayload: XMLMappable {
    var nodeName: String!

    var stopEventResponse: StopEventResponse?
   

    required init?(map: XMLMap) {}

    func mapping(map: XMLMap) {
        stopEventResponse <- map["trias:StopEventResponse"]
        
    }
}
class StopEventResponse: XMLMappable {
    var nodeName: String!
    var  errorMessage: ErrorMessage?


    var stopEventResults: [StopEventResult]?
   

    required init?(map: XMLMap) {}

    func mapping(map: XMLMap) {
        errorMessage <- map["trias:ErrorMessage"]

        stopEventResults <- map["trias:StopEventResult"]
        
    }
}
class ErrorMessage: XMLMappable {
    var nodeName: String!

    var code: Int?
    var text : Text?
    required init?(map: XMLMap) {}

    func mapping(map: XMLMap) {
        code <- map["trias:Code"]
        text <- map["trias:Text"]

    }
}
class Text: XMLMappable {
    var nodeName: String!

    var text: String?

    required init?(map: XMLMap) {}

    func mapping(map: XMLMap) {
        text <- map["trias:Text"]

    }
}
class StopEventResult: XMLMappable {
    var nodeName: String!

    var stopEvent: StopEvent?

    required init?(map: XMLMap) {}

    func mapping(map: XMLMap) {
        stopEvent <- map["trias:StopEvent"]

    }
}
class StopEvent: XMLMappable {
    var nodeName: String!
    
    var service: Service?
    var callAtStop: CallAtStop?

    required init?(map: XMLMap) {}

    func mapping(map: XMLMap) {
        callAtStop <- map["trias:CallAtStop"]
        service <- map["trias:Service"]

        
    }
}
class Service: XMLMappable {
    var nodeName: String!
    
    var journeyRef: String?
    var transportationMode : TransportationMode?
    var publishedLineName : PublishedLineName?
    var originText : OriginText?
    var destinationText : DestinationText?


    required init?(map: XMLMap) {}

    func mapping(map: XMLMap) {
        journeyRef <- map["trias:JourneyRef"]
        transportationMode <- map["trias:Mode"]

        publishedLineName <- map["trias:PublishedLineName"]

        originText <- map["trias:OriginText"]

        destinationText <- map["trias:DestinationText"]


        
    }
}
class DestinationText: XMLMappable {
    var nodeName: String!

    var text: String?

    required init?(map: XMLMap) {}

    func mapping(map: XMLMap) {
        text <- map["trias:Text"]

    }
}
class OriginText: XMLMappable {
    var nodeName: String!

    var text: String?

    required init?(map: XMLMap) {}

    func mapping(map: XMLMap) {
        text <- map["trias:Text"]

    }
}
class PublishedLineName: XMLMappable {
    var nodeName: String!

    var text: String?

    required init?(map: XMLMap) {}

    func mapping(map: XMLMap) {
        text <- map["trias:Text"]

    }
}
class TransportationMode: XMLMappable {
    var nodeName: String!

    var name: Name?

    required init?(map: XMLMap) {}

    func mapping(map: XMLMap) {
        name <- map["trias:Name"]

    }
}
class Name: XMLMappable {
    var nodeName: String!

    var text: String?

    required init?(map: XMLMap) {}

    func mapping(map: XMLMap) {
        text <- map["trias:Text"]

    }
}


class CallAtStop: XMLMappable {
    var nodeName: String!

    var serviceDeparture: ServiceDeparture?
    var plannedBay:PlannedBay?

    required init?(map: XMLMap) {}

    func mapping(map: XMLMap) {
        serviceDeparture <- map["trias:ServiceDeparture"]
        plannedBay <- map["trias:PlannedBay"]

        
    }
}
class ServiceDeparture: XMLMappable {
    var nodeName: String!

    var timetabledTime: String?
    var estimatedTime: String?


    required init?(map: XMLMap) {}

    func mapping(map: XMLMap) {
        timetabledTime <- map["trias:TimetabledTime"]
        estimatedTime <- map["trias:EstimatedTime"]

    }
}
class PlannedBay: XMLMappable {
    var nodeName: String!

    var BayName: String?


    required init?(map: XMLMap) {}

    func mapping(map: XMLMap) {
        BayName <- map["trias:Text"]

    }
}
