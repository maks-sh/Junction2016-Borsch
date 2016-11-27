//
//  NSDictionary+Helper.swift
//
//  Created by Alex Shoshiashvili on 14.02.16.
//  Copyright © 2016 alexsho. All rights reserved.
//

import Foundation

extension NSDictionary {
  
  var jsonObjectData: NSData? {
    let result = try? NSJSONSerialization.dataWithJSONObject(self, options: [])
    return result
  }
}