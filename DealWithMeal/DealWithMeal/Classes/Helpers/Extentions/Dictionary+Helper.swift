//
//  Dictionary+Helper.swift
//
//  Created by Alex Shoshiashvili on 14.02.16.
//  Copyright © 2016 alexsho. All rights reserved.
//

import UIKit

extension Dictionary {
  
  var jsonObjectData: NSData? {
    let result = try? NSJSONSerialization.dataWithJSONObject(self as! AnyObject, options: [])
    return result
  }
  
  mutating func update(other:Dictionary) {
    for (key,value) in other {
      self[key] = value
    }
  }
}
