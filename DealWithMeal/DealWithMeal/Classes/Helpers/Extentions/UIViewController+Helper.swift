//
//  UIViewController+Helper.swift
//  Molnia
//
//  Created by Alex Shoshiashvili on 30.07.16.
//  Copyright © 2016 Alex Shoshiashvili. All rights reserved.
//

import UIKit

extension UIViewController {
  
  // MARK: = Segue
  
  func performSegueWithIdentifier(identifier: SegueIdentifier, sender: AnyObject?) {
    self.performSegueWithIdentifier(identifier.rawValue, sender: sender)
  }
  
  // MARK: - Notification
  
  func addNotificationObServer(name: GlobalNotificationConstant, selector: Selector, object: AnyObject? = nil) {
    NSNotificationCenter.addObserverNotification(self, selector: selector, notificationName: name, object: object)
  }
  
  func removeNotificationObserver(name: GlobalNotificationConstant? = nil, object: AnyObject? = nil) {
    NSNotificationCenter.removeObserver(self, notificationName: name, object: object)
  }
  
}