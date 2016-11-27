//
//  NSData+Helper.swift
//
//  Created by Alex Shoshiashvili on 14.02.16.
//  Copyright © 2016 alexsho. All rights reserved.
//

import Foundation

extension NSData {
  
  var serializedJSONObject: [String: AnyObject]? {
    return (try? NSJSONSerialization.JSONObjectWithData(self, options: NSJSONReadingOptions.AllowFragments)) as? Dictionary<String, AnyObject>
  }
  
  var serializedJSONObjectToArray: [AnyObject]? {
    return (try? NSJSONSerialization.JSONObjectWithData(self, options: NSJSONReadingOptions.AllowFragments)) as? Array<AnyObject>
  }
  
}