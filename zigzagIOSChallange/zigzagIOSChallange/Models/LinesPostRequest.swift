//
//  RoutsPostRequest.swift
//  XMLparsing
//
//  Created by Mac on 7/2/21.
//
import XMLMapper
import Foundation
let Poststr = """
<Trias version="1.1" xmlns="http://www.vdv.de/trias" xmlns:siri="http://www.siri.org.uk/siri">

<ServiceRequest>

<siri:RequestTimestamp>2019-04-05T12:00:00</siri:RequestTimestamp>

<siri:RequestorRef>zigzag0719</siri:RequestorRef>

<RequestPayload>

<StopEventRequest>

<Location>

<LocationRef>

<StopPointRef>de:08111:6333</StopPointRef>
 </LocationRef>
 </Location>

<Params>

<NumberOfResults>100</NumberOfResults>

<StopEventType>departure</StopEventType>

<PtModeFilter>

<Exclude>false</Exclude>
 </PtModeFilter>

<IncludeRealtimeData>true</IncludeRealtimeData>
 </Params>
 </StopEventRequest>
 </RequestPayload>
 </ServiceRequest>
</Trias>
"""

class Trias: XMLMappable {
    var nodeName: String!

    var serviceRequest: ServiceRequest?
    var version : Float = 1.1
    var xmlns : String = "http://www.vdv.de/trias"
    var xmlnsSiri : String = "http://www.siri.org.uk/siri"

    required init?(map: XMLMap) {}

    func mapping(map: XMLMap) {
        serviceRequest <- map["ServiceRequest"]
        version <- map.attributes["version"]
        xmlns <- map.attributes["xmlns"]
        xmlnsSiri <- map.attributes["xmlns:siri"]


    }
}
class ServiceRequest: XMLMappable {
    var nodeName: String!

    var requestTimestamp: String? = "2019-04-05T12:00:00"
    var requestorRef : String = "zigzag0719"
    var requestPayload : RequestPayload?

    required init?(map: XMLMap) {}

    func mapping(map: XMLMap) {
        requestTimestamp <- map["siri:RequestTimestamp"]
        requestorRef <- map["siri:RequestorRef"]
        requestPayload <- map["RequestPayload"]
    }
}
class RequestPayload: XMLMappable {
    var nodeName: String!

    var stopEventRequest: StopEventRequest?
   

    required init?(map: XMLMap) {}

    func mapping(map: XMLMap) {
        stopEventRequest <- map["StopEventRequest"]
    }
}
class StopEventRequest: XMLMappable {
    var nodeName: String!

    var location: Location?
    var params: Params?

    required init?(map: XMLMap) {}

    func mapping(map: XMLMap) {
        location <- map["Location"]
        params <- map["Params"]

    }
}
class Params: XMLMappable {
    var nodeName: String!

    var numberOfResults: Int = 100
    var stopEventType : String = "departure"
    var ptModeFilter : ModeFilter?
    var includeRealtimeData : Bool = true
    
    required init?(map: XMLMap) {}

    func mapping(map: XMLMap) {
        numberOfResults <- map["NumberOfResults"]
        stopEventType <- map["StopEventType"]
        ptModeFilter <- map["PtModeFilter"]
        includeRealtimeData <- map["IncludeRealtimeData"]


    }
}
class ModeFilter: XMLMappable {
    var nodeName: String!

    var exclude: Bool = false

    required init?(map: XMLMap) {}

    func mapping(map: XMLMap) {
        exclude <- map["Exclude"]

    }
}
class Location: XMLMappable {
    var nodeName: String!

    var locationRef: LocationRef?

    required init?(map: XMLMap) {}

    func mapping(map: XMLMap) {
        locationRef <- map["LocationRef"]

    }
}
    class LocationRef: XMLMappable {
        var nodeName: String!

        var stopPointRef: String?

        required init?(map: XMLMap) {}

        func mapping(map: XMLMap) {
            stopPointRef <- map["StopPointRef"]

        }
}

