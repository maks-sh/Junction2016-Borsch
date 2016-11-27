//
//  RestServices.swift
//  DealWithMeal
//
//  Created by Alex Shoshiashvili on 26.11.16.
//  Copyright © 2016 Alex Shoshiashvili. All rights reserved.
//

import UIKit

class RestServices: MainServices {
  
  //
  
  class func restaurants(uiHandler: ((error: NSError?, restaurants: [Restaurant]?) -> ())?) {
    
    Networking.upload(.GET, url: "http://188.166.65.99:8080/api/get/restaurants/", parameters: [:]) { (error, response) in
      
      if error != nil {
       uiHandler?(error: error, restaurants: nil)
      } else {
        
        let resp = response?.rawValue as! [[String: AnyObject]]
        
        var rests = [Restaurant]()
        
        for restDict in resp {
          let rest = Restaurant(restDict)
          rests.append(rest)
        }
        
        uiHandler?(error: nil, restaurants: rests)
        
      }
    }
    
  }
  
  class func restaurantsWithCoordinates(coordinates: String, uiHandler: ((error: NSError?, restaurants: [Restaurant]?) -> ())?) {
    
    let parameters: [String : AnyObject] = ["coords": coordinates]
    
    Networking.upload(.GET, url: "http://188.166.65.99:8080/api/get/restaurants/coords", parameters: parameters) { (error, response) in
      
      if error != nil {
        uiHandler?(error: error, restaurants: nil)
      } else {
        
        let resp = response?.rawValue as! [[String: AnyObject]]
        
        var rests = [Restaurant]()
        
        for restDict in resp {
          let rest = Restaurant(restDict)
          rests.append(rest)
        }
        
        uiHandler?(error: nil, restaurants: rests)
        
      }
    }
    
  }
  
  class func restaurantsWithName(name: String, uiHandler: ((error: NSError?, restaurants: [Restaurant]?) -> ())?) {
    
    let parameters: [String : AnyObject] = ["name": name]
    
    Networking.request(.GET, "http://188.166.65.99:8080/api/get/search/restaurants/", parameters: parameters, encoding: .URL, headers: nil) { (error, response) in
      if error != nil {
        uiHandler?(error: error, restaurants: nil)
      } else {
        
        let resp = response?.rawValue as! [[String: AnyObject]]
        
        var rests = [Restaurant]()
        
        for restDict in resp {
          let rest = Restaurant(restDict)
          rests.append(rest)
        }
        
        uiHandler?(error: nil, restaurants: rests)
        
      }
    }
    
//    Networking.upload(.GET, url: "http://188.166.65.99:8080/api/get/search/restaurants/", parameters: parameters) { (error, response) in
//      
//      if error != nil {
//        uiHandler?(error: error, restaurants: nil)
//      } else {
//        
//        let resp = response?.rawValue as! [[String: AnyObject]]
//        
//        var rests = [Restaurant]()
//        
//        for restDict in resp {
//          let rest = Restaurant(restDict)
//          rests.append(rest)
//        }
//        
//        uiHandler?(error: nil, restaurants: rests)
//        
//      }
//    }
    
  }
  
  class func restaurantById(restId id: String, uiHandler: ((error: NSError?, restaurantById: Restaurant?) -> ())?) {
    
    
    
    Networking.upload(.GET, url: "http://188.166.65.99:8080/api/get/restaurant/" + id, parameters: [:]) { (error, response) in
      
      if error != nil {
        uiHandler?(error: error, restaurantById: nil)
      } else {
        let resp = response?.rawValue as! [String: AnyObject]
        let rest = Restaurant(resp)
        uiHandler?(error: nil, restaurantById: rest)
      }
    }
    
  }
  
}
