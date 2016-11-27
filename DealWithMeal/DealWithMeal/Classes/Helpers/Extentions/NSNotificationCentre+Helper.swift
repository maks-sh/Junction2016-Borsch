//
//  NSNotificationCentre+Helper.swift
//  Molnia
//
//  Created by Alex Shoshiashvili on 30.07.16.
//  Copyright © 2016 Alex Shoshiashvili. All rights reserved.
//

import Foundation

extension NSNotificationCenter {
  
  private static func nameFor(notification: GlobalNotificationConstant) -> String {
    return "\(notification.rawValue)"
  }
  //<GlobalNotificationConstant:RawRepresentable where GlobalNotificationConstant.RawValue==String>
  class func postNotification(notificationName: GlobalNotificationConstant, object: AnyObject? = nil) {
    let dc = defaultCenter()
    dc.postNotificationName(nameFor(notificationName), object: object)
  }
  
  class func addObserverNotification(observer: AnyObject, selector: Selector, notificationName: GlobalNotificationConstant, object: AnyObject? = nil) {
    let dc = defaultCenter()
    dc.addObserver(observer, selector: selector, name: notificationName.rawValue, object: object)
  }
  
  class func removeObserver (observer: AnyObject, notificationName: GlobalNotificationConstant? = nil, object: AnyObject? = nil) {
    let dc = defaultCenter()
    dc.removeObserver(observer, name: notificationName?.rawValue, object: object)
  }
  
}