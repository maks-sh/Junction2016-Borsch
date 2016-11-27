//
//  Networking.swift
//  Molnia
//
//  Created by Alex Shoshiashvili on 27.07.16.
//  Copyright © 2016 Alex Shoshiashvili. All rights reserved.
//

import Alamofire
import SwiftyJSON

class Request {
  var schemaName = ""
  var name = ""
  var string = ""
}

class Networking {
  
  static var mgr: Alamofire.Manager!
  static let cookies = NSHTTPCookieStorage.sharedHTTPCookieStorage()
  
  class func configureManager() -> Alamofire.Manager {
    let cfg = NSURLSessionConfiguration.defaultSessionConfiguration()
    cfg.HTTPCookieStorage = cookies
    return Alamofire.Manager(configuration: cfg)
  }
  
  class func request(
    method: Alamofire.Method,
    _ URLString: String? = APIConstants.baseURL,
      parameters: [String: AnyObject]? = nil,
      encoding: ParameterEncoding = .JSON,
      headers: [String: String]? = nil,
      uiHandler: ((error: NSError?, response: JSON?) -> ())?) {

    
    
    
    Alamofire.request(method, URLString!, parameters: parameters, encoding: encoding, headers: headers).responseJSON { (response) in
      
      print(response)
      
      switch response.result {
      case .Success:
        if let responseData = response.data {
          let json = JSON(data: responseData)
          let responseJson = json //["data"]
          uiHandler?(error: nil, response: responseJson)
        }
      case .Failure(let error):
        print("ERROR REQUEST: \(parameters)\nREASON: \(error.localizedDescription)")
        uiHandler?(error: error, response: nil)
      }
    }
    
  }
  
  class func upload(method: Alamofire.Method = .POST, url: String, parameters: [String: AnyObject], uiHandler: ((error: NSError?, response: JSON?) -> ())?) {
    
    mgr = configureManager()
    
    Alamofire.upload(
      method,
      url,
      multipartFormData: { multipartFormData in
        for (key, value) in parameters {
          multipartFormData.appendBodyPart(data: value.dataUsingEncoding(NSUTF8StringEncoding)!, name: key)
        }
      }, encodingCompletion: { encodingResult in
        switch encodingResult {
        case .Success(let upload, _, _):
          upload.responseJSON { response in
            debugPrint(response)
            
            if url == "http://188.166.65.99:8080/api/auth/login/" {
//              let cookies = NSHTTPCookie.cookiesWithResponseHeaderFields(response.response!.allHeaderFields as! [String: String], forURL: response.response!.URL!)
//              Alamofire.Manager.sharedInstance.session.configuration.HTTPCookieStorage?.setCookies(cookies, forURL: response.response!.URL!, mainDocumentURL: nil)
            }
            
            if let value = response.result.value {
              let resp = JSON(value)
              uiHandler?(error: nil, response: resp)
            } else {
              let errorValue = NSError(message: "errorValue: value is nil")
              uiHandler?(error: errorValue, response: nil)
            }
            
          }
        case .Failure(let encodingError):
          print(encodingError)
          let error = NSError(message: "sadkoasdo")
          uiHandler?(error: error, response: nil)
        }
      }
    )
  }
  
}
