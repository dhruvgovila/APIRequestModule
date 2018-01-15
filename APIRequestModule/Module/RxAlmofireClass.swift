//
//  RxAlmofiree.swift
//  BolierPlateSample
//
//  Created by Dhruv Govila on 10/11/17.
//  Copyright © 2017 Dhruv Govila. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxAlamofire
import Alamofire

class RxAlmofireClass {
    
    static let sharedInstance = RxAlmofireClass()
    
    let disposebag = DisposeBag()
    let apiResponse = PublishSubject<ApiResponse>()
    
    //preventing the initialization of the class
    private init(){
        
    }
    
    func newtworkRequestAPIcall (serviceName:String ,requestType: Alamofire.HTTPMethod  , parameters: [String:Any]?,headerParams: [String:String],responseType:String){
        
        //Give the URL Name
        let strURL = "https://www.googleapis.com/youtube/v3/channels?part=contentDetails&mine=true"
        
        //Make the APICall by invoking RxAlamofire API
        RxAlamofire
            .requestJSON(requestType, strURL ,parameters:parameters, headers: headerParams)
            .debug()
            .subscribe(onNext: { (header, jsonBody) in
                if  var dict  = jsonBody as? [String:Any]{
                    var statuscode:Int = header.statusCode
                    if dict["code"] != nil{ statuscode = (dict["code"] as? Int)!}
                    self.checkResponse(statusCode: statuscode, responseDict: dict ,reposeType: responseType)
                }
            }, onError: {  (error) in
                self.apiResponse.onError(error)
                print(error.localizedDescription)
                
            }).disposed(by: disposebag)
    }
    
    //Check the response statusCode and if the statuscode is success then pass it to the observer
    func checkResponse(statusCode:Int,responseDict: [String:Any],reposeType:String){
        
        let apiResponseStatusCode: APIErrors.ErrorCode = APIErrors.ErrorCode(rawValue: statusCode)
        switch apiResponseStatusCode {
        case .success:
            self.apiResponse.onNext(ApiResponse.init(status: true, response: responseDict))
            
        default:
            print("Some Error Occured")
            self.apiResponse.onError(NSError(domain: "", code: statusCode, userInfo: ["message":responseDict["message"] as! String]))
        }
    }
    
}


