//
//  LinesDetailsInteractor.swift
//  zigzagIOSChallange
//
//  Created by Mac on 7/5/21.
//

import Foundation
class LinesDetailsInteractor
{
    var networkManger = NetworkLayer()

   weak var presenter : LinesDetailsInteractorOutput?
    
}
extension LinesDetailsInteractor : LinesDetailsInteractorInput
{
    
    func perform(LinesDetails: Perform.GetLineCoord) {
        let journeyRef = "vvs:10001::H:j21:194"
        networkManger.GetRequest(Model: LinesCoordinatesResponse.self, RequestConfiq: NetworkRouter.GetLinesCoordinate(journeyRef), completionHandler:   {
           respose,State in
                     //    print(respose)
           switch State
            {
           case .empty:
            print("No Data Found")
              
            return
           case .error(let error):
            print(error)
            return
           case .Success:
            print("Success")
            let coords = respose as? LinesCoordinatesResponse
            print(coords?.transportations?[0].coords?[0][1][1])
            var linesCoord  = TransportationLinesDetails.LinesCoordsResponse()
            if let coordData = coords?.transportations?[0].coords
            {
                linesCoord.LinesCoordList = coordData
                self.presenter?.present(LinesCoordsData: linesCoord)

            }

           }
            
    })
        }
    func perform(LinesDetails: Perform.GetLineDetails) {
        print("perform interactor task")
        let stopPointRef =  "de:08111:6333"
        networkManger.XMLPostRequest(Model: Routes.self, RequestConfiq: NetworkRouter.GetLinesData(stopPointRef), completionHandler:   {
           respose,State in
                     //    print(respose)
           switch State
            {
           case .empty:
            print("No Data Found")
              
            return
           case .error(let error):
            print(error)
            return
           case .Success:
            print("Success")
            var stringResponse = respose as? String

            let routs = Routes(XMLString: stringResponse ?? "")
            if let error = routs?.serviceDelevery?.deliveryPayload?.stopEventResponse?.errorMessage
            {
                print(error.text?.text)
                return
            }
            guard let data =  routs?.serviceDelevery?.deliveryPayload?.stopEventResponse
            else{
                print("no data or parse error")
                return
            }
            print(routs?.serviceDelevery?.deliveryPayload?.stopEventResponse?.stopEventResults?[0].stopEvent?.service?.originText?.text)
          //  var LinesData = LinesDetails.Response()
            if let LinesData = routs?.serviceDelevery?.deliveryPayload?.stopEventResponse?.stopEventResults
            {
                var LinesResponse = TransportationLinesDetails.Response()
                
                LinesResponse.LinesList = LinesData
                
               self.presenter?.present(LinesData : LinesResponse)
            }
            

            }
            
                      })
    }
    
}
