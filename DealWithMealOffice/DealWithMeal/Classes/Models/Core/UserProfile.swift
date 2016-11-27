//
//  UserProfile.swift
//
//  Created by Alex Shoshiashvili on 14.02.16.
//  Copyright © 2016 alexsho. All rights reserved.
//

import UIKit

enum CardType : Int {
  case Mastercard
  case Visa
}

class UserProfile: NSObject {

  var writeJson = [String:[String:AnyObject]]()
  
  var userId = 1 {
    didSet {
      writeJson["userProfile"]?["id"] = userId
    }
  }
  
//  var userRawId = "" {
//    didSet {
//      writeJson["userProfile"]?["rawId"] = userId
//    }
//  }
  
  var phone = "" {
    didSet {
      writeJson["userProfile"]?["phone_number"] = phone
    }
  }
  
  var udid = "" {
    didSet {
      writeJson["userProfile"]?["udid"] = udid
    }
  }
  
  var token = "" {
    didSet {
      writeJson["userProfile"]?["token"] = token
    }
  }
  
  var restaurant = Restaurant() {
    didSet {
      writeJson["userProfile"]?["restaurant"] = restaurant
    }
  }
  
  var restaurant_name = "" {
    didSet {
      writeJson["userProfile"]?["restaurant_name"] = restaurant_name
    }
  }
  
  var first_name = "" {
    didSet {
      writeJson["userProfile"]?["first_name"] = first_name
    }
  }
  
  var last_name = "" {
    didSet {
      writeJson["userProfile"]?["last_name"] = last_name
    }
  }
  
  var is_waiter = false {
    didSet {
      writeJson["userProfile"]?["is_waiter"] = is_waiter
    }
  }
  
  var is_admin_restaurant = false {
    didSet {
      writeJson["userProfile"]?["is_admin_restaurant"] = is_admin_restaurant
    }
  }

  var cardType : CardType = .Mastercard
  
  convenience override init() {
  self.init([String:AnyObject]())
  }

  init (_ dictionary: [String:AnyObject]) {
    
    writeJson["userProfile"] = dictionary
    
    if let newId = dictionary["id"] as? Int {
      userId = newId
    }
    
    if let newPhone = dictionary["phone"] as? String {
      phone = newPhone
    }
    
    if let newUdid = dictionary["udid"] as? String {
      udid = newUdid
    }
    
    if let newToken = dictionary["token"] as? String {
      if newToken.characters.count > 0 {
        token = newToken
      }
    }
    
//    if let newUniversity = dictionary["university"] as? [String: AnyObject] {
//      university = University(newUniversity)
//    }
//    
//    if let newUniversityFromCache = dictionary["university"] as? University {
//      university = newUniversityFromCache
//    }
//    
//    if let newSchool_class = dictionary["school_class"] as? Int {
//      school_class = newSchool_class
//    }
//    
//    if let newOnline = dictionary["online"] as? Bool {
//      online = newOnline
//    }
//    
//    if let newRating = dictionary["rating"] as? Double {
//      rating = newRating
//    }
//    
//    if let newTasks = dictionary["tasks"] as? [[String:AnyObject]] {
//      for task in newTasks {
//        let taskEntity = Task(task)
//        tasks.append(taskEntity)
//      }
//    }
    
  }
  
  func copyWithZone(zone: NSZone) -> AnyObject! {
  
    let newValue = UserProfile([String:AnyObject]())

    return newValue
  }
  
  required init(coder aDecoder: NSCoder) {
    if let userId = aDecoder.decodeObjectForKey("userId") as? String {
      //
    }
  }
  
  func encodeWithCoder(aCoder: NSCoder) {
      aCoder.encodeObject(userId, forKey: "userId")
  }
  
}