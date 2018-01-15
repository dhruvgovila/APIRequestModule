//
//  ApiRequestDemo.swift
//  APIRequestModule
//
//  Created by Dhruv Govila on 15/01/18.
//  Copyright © 2018 Dhruv Govila. All rights reserved.
//

import UIKit
import RxSwift
class ApiRequestDemo {
    
    func makeServiceCall(){
        
        //define the parameters that needs to be send in the APIRequest
        let requestParameter = ["module" : "APIRequestModule",
                                "version" : "1.0"]
        
        //define the header parameters that needs to be send in the APIRequest
        let headerParameter = ["requestToken" : "abc123!@#"]
        
        //make the APIRequestCall
        let rxAlamofireClass = RxAlmofireClass.sharedInstance
        rxAlamofireClass.newtworkRequestAPIcall(serviceName: "googleApi", requestType: .post, parameters: requestParameter, headerParams: headerParameter, responseType: "GoogleApi")
        
        //observe the APIRequestCall via RxSwift
        _ = rxAlamofireClass.apiResponse.subscribe(onNext: { (response) in
            switch response.status{
            case true:
                print(response)
                break
            
            default:
                print("Some error occurred")
            }
            
            
        }, onError: { (error) in
            print("Some Error Occured")
        }, onCompleted: {
            
        }) {
            
        }
    }
}
