# Network API Request Module
This module can be used for making Network API Request Calls in the App.
This is written in Swift Programming Language.

It consists of Four Classes:
1. APIRequest.swift
   This class contains a global function to make the service call and to check the response.
   This class is a singleton class.
   
2. ApiResponseModel.swift
   This class is a model class. This is used to make a model of the response from the Network API Request Calls, which can be then passes on to the control where the API Call was initiated.

3. APIErrors.swift
   This class contains the enum and functions to check whether the response of the Network API Request Call is success or failed.
   
4. ApiRequestDemo.swift   
   This class contains the function to demonstrate the Network API Request Call
   
Dependencies Used:
1. Alamofire
2. RxAlamofire
3. RxSwift
