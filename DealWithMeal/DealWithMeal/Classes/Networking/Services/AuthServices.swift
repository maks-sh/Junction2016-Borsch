//
//  AuthServices.swift
//
//  Created by Alex Shoshiashvili on 14.02.16.
//  Copyright © 2016 alexsho. All rights reserved.
//

import Foundation
import Alamofire

class AuthServices: MainServices {
  
  //MARK: - Authorization API
  
  class func singUp(withPhone phone: String, email: String, password: String, uiHandler: ((error: NSError?, userProfile: UserProfile?) -> ())?) {
    
    let phoneDigits = phone.digitsOnly()
    let parameters: [String : AnyObject] = [
      "phone_number": phoneDigits,
      "first_name": phoneDigits,
      "last_name": phoneDigits,
      "email": email,
      "password": password,
      "is_admin_restaurant" : "False",
      "is_waiter": "False"]

    Networking.request(.POST, "http://188.166.65.99:8080/api/register/", parameters: parameters, encoding: .URL, headers: nil) { (error, response) in
      if error != nil {
        let error = NSError(message: "sadkoasdo")
        uiHandler?(error: error, userProfile: nil)
      } else {
        let newUser = UserProfile()
        newUser.userId = 1
        newUser.token = "token"
        UserProfileData.sharedInstance.userData = newUser
        uiHandler?(error: nil, userProfile: UserProfileData.sharedInstance.userData)
      }
    }
    
//    Alamofire.upload(
//      .POST,
//      "http://188.166.65.99:8080/api/register/",
//      multipartFormData: { multipartFormData in
//        for (key, value) in parameters {
//          multipartFormData.appendBodyPart(data: value.dataUsingEncoding(NSUTF8StringEncoding)!, name: key)
//        }
//      }, encodingCompletion: { encodingResult in
//        switch encodingResult {
//        case .Success(let upload, _, _):
//          upload.responseJSON { response in
//            debugPrint(response)
//            let newUser = UserProfile()
//            newUser.userId = 1
//            newUser.token = "token"
//            UserProfileData.sharedInstance.userData = newUser
//            uiHandler?(error: nil, userProfile: UserProfileData.sharedInstance.userData)
//          }
//        case .Failure(let encodingError):
//          print(encodingError)
//          let error = NSError(message: "sadkoasdo")
//          uiHandler?(error: error, userProfile: nil)
//        }
//      }
//    )
    
    
  }
  
  class func signIn(phone phone: String, password: String, uiHandler: ((error: NSError?, userProfile: UserProfile?) -> ())?) {
//    success: function () {
//      $.ajax({
//        type: 'POST',
//        url: 'http://188.166.65.99:8080/api/auth/login/',
//        data: {
//          'phone_number': data.phone_number,
//          'password': data.password
//        }, xhrFields: {
//          withCredentials: true,
//        },
//        success: function () {
//          window.location.href = "http://127.0.0.1:8000/j-rest/";
//          
//          
//        }
//      })
//    }
    
    let phoneDigits = phone.digitsOnly()
    let parameters: [String : AnyObject] = ["phone_number": phoneDigits, "password": password]
    
    Networking.request(.POST, "http://188.166.65.99:8080/api/auth/login/", parameters: parameters, encoding: .URL, headers: nil) { (error, response) in
      uiHandler?(error: error, userProfile: nil)
    }
    
//    Networking.upload(url: "http://188.166.65.99:8080/api/auth/login/", parameters: parameters) { (error, response) in
//    }
  
  }
  
  class func getRestaurantById(restId: String) {
    
  }
  
  class func addFeedback() {
    // /api/add/feedback/
    
    let parameters: [String : AnyObject] = ["feedback": "Huevo, no prikolno, no huevo", "restaurant_id": "4"]
    
    Networking.upload(url: "http://188.166.65.99:8080/api/add/feedback/", parameters: parameters) { (error, response) in
    }
    
  }
  
}