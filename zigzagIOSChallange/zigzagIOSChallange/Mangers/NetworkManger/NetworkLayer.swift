//
//  NetworkLayer.swift
//  MREC
//
//  Created by developer on 07/05/2020.
//  Copyright © 2020 developer. All rights reserved.
//

import Foundation
import Alamofire
import XMLMapper
class NetworkLayer {
    
    
       var AnyModel :Any!
    typealias CompletionHandler = (Any,State) -> Void
    init() {
        
    }
    //swicher
    func Request<T>( ResponseModel: T.Type,RequestConfiq: NetworkRouter,completionHandler: @escaping  CompletionHandler) where T: Decodable, T: XMLMappable
    {
        switch RequestConfiq.GetMethod() {
      
      case "Get":
             GetRequest(Model: ResponseModel, RequestConfiq: RequestConfiq, completionHandler: completionHandler)
              print("Get Request Proceed")
        case "XMLPost":
               XMLPostRequest(Model: ResponseModel, RequestConfiq: RequestConfiq, completionHandler: completionHandler)
                print("XML post Request Proceed")
        default:
            print("No Method setted")
        }
    }
    public  func GetRequest<T:Decodable>( Model: T.Type,RequestConfiq: NetworkRouter,completionHandler: @escaping  CompletionHandler)
      {
        
  
        let request = AF.request(RequestConfiq.GetUrl())
       // var utf8Text = ""
        
       request.responseJSON
        {
            data  in
         
            print(RequestConfiq.GetUrl())
            print("mydata")
            print(data)
                print(Model)
          
            switch data.result {
            case .failure(let error):
             // self.NetworkErrorHandle(ErrorMessage :" Check your Internet Connection ")
               print(error)
                completionHandler(self.AnyModel,.error("cant connect to server"))
              return
                // Do your code here...

            case .success(_):
                print("Success")
                if data.data == nil
                          {
                              print("NoData")
                           completionHandler(self.AnyModel,.empty)
                            return
                          }
            }
        
            do{
                self.AnyModel =  try  JSONDecoder().decode(Model, from: data.data!)


           }


           catch{


               print("error im parsssssing")


           }
           
        //    MinValue = self.Intro.MinYesToPass!
        //print(self.Intro.MinYesToPass)
            completionHandler(self.AnyModel,.Success)
      }
     
     //   return MinValue
    }
    
    public  func XMLPostRequest<T:XMLMappable>( Model: T.Type,RequestConfiq: NetworkRouter,completionHandler: @escaping  CompletionHandler)
    {
        let trias = Trias(XMLString: Poststr)
        trias?.serviceRequest?.requestPayload?.stopEventRequest?.location?.locationRef?.stopPointRef = RequestConfiq.GetPostBodyInfo()//"de:08111:6333"
        let TriasString = trias?.toXMLString()
        let url = URL(string: RequestConfiq.GetUrl())
        var xmlRequest = URLRequest(url: url!)
      xmlRequest.httpBody = TriasString?.data(using: String.Encoding.utf8, allowLossyConversion: true)
        xmlRequest.httpMethod = "POST"
        xmlRequest.addValue("application/xml", forHTTPHeaderField: "Content-Type")


        AF.request(xmlRequest)
                .responseData { (response) in
                    switch response.result {
                    case .failure(let error):
                       print(error)
                        completionHandler(self.AnyModel,.error("cant connect to server"))
                      return
                    case .success(_):
                        let stringResponse: String = String(data: response.data!, encoding: String.Encoding.utf8) as String? ?? ""
                        print("Success")
                        print(stringResponse)
                        if response.data == nil || stringResponse == ""
                                  {
                                      print("NoData")
                                   completionHandler(self.AnyModel,.empty)
                                    return
                                  }
                        completionHandler(stringResponse,.Success)
                       
                       
                     
                      
                    }

                    
                  
                    
                

        }
    }
    

}
