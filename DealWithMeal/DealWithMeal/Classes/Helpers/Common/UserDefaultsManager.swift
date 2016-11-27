//
//  UserDefaultsManager.swift
//
//  Created by Alex Shoshiashvili on 14.02.16.
//  Copyright © 2016 alexsho. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

typealias CookieName = String

struct UserDefaultsConstants {
  static let firstRunKey = "first_run_preference"
  static let baseURLKey = "baseUrlKey_preference"
  static let cachedUserProfileDict = "cachedUserProfileDict_preference"
  static let deferredPriceKey = "deferredPriceKey_preference"
  static let urgenciesKey = "urgenciesKey_preference"
}

class UserDefaultsManager {
  static let sharedInstance = UserDefaultsManager()
  private init() {}
  
  class var isFirstRun: Bool {
    get {
      return NSUserDefaults.standardUserDefaults().boolForKey(UserDefaultsConstants.firstRunKey) as Bool
    }
    set {
      setValue(newValue, forKey: UserDefaultsConstants.firstRunKey)
    }
  }
  
  class var cachedUserProfileDict: [String:AnyObject]? {
    get {
      if let profileDictData = NSUserDefaults.standardUserDefaults().dataForKey(UserDefaultsConstants.cachedUserProfileDict) {
        let profileDict = NSKeyedUnarchiver.unarchiveObjectWithData(profileDictData) as! [String:AnyObject]
        return profileDict
      }
      print("Cached user profile not found")
      return [String:AnyObject]()
    }
    
    set {
      if let profile = newValue {
        let data = NSKeyedArchiver.archivedDataWithRootObject(profile)
        setValue(data, forKey: UserDefaultsConstants.cachedUserProfileDict)
        print("User profile cached")
      } else {
        removeValueForKey(UserDefaultsConstants.cachedUserProfileDict)
      }
    }
  }

  class var clientConfigDeferredPrice: Float {
    get {
      return NSUserDefaults.standardUserDefaults().floatForKey(UserDefaultsConstants.deferredPriceKey) as Float
    }
    set {
      setValue(newValue, forKey: UserDefaultsConstants.deferredPriceKey)
    }
  }
  
  class var clientConfigUrgencies: [[String: AnyObject]] {
    get {
      let urgenciesDicts = NSUserDefaults.standardUserDefaults().valueForKey(UserDefaultsConstants.urgenciesKey) as? [[String: AnyObject]]
      if let urgencies = urgenciesDicts {
        return urgencies
      } else {
        return [[String: AnyObject]]()
      }
    }
    set {
      for urgent in newValue {
        
        let urgentId = urgent["id"] as! String
        let urgentName = urgent["name"] as! String
        let urgentPrice = urgent["price"] as! Float
        let urgentExpireIn = urgent["expireIn"] as! Double
        
        switch urgentId {
        case "urgent":
          ExpirationNames.urgent = urgentName
          ExpirationPrices.urgent = urgentPrice
          ExpirationTimeIntervals.urgent = urgentExpireIn
        case "middle":
          ExpirationNames.oneDay = urgentName
          ExpirationPrices.oneDay = urgentPrice
          ExpirationTimeIntervals.oneDay = urgentExpireIn
        case "long":
          ExpirationNames.oneWeek = urgentName
          ExpirationPrices.oneWeek = urgentPrice
          ExpirationTimeIntervals.oneWeek = urgentExpireIn
        default:
          break
        }
        
      }
      
      setValue(newValue, forKey: UserDefaultsConstants.urgenciesKey)
    }
  }
  
  class func setValue(value: AnyObject?, forKey key: String) {
    NSUserDefaults.standardUserDefaults().setObject(value, forKey: key)
    NSUserDefaults.standardUserDefaults().synchronize()
  }
  
  class func removeValueForKey(key: String) {
    NSUserDefaults.standardUserDefaults().removeObjectForKey(key)
    NSUserDefaults.standardUserDefaults().synchronize()
  }
  
}
