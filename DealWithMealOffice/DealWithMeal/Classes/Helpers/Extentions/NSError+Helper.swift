//
//  NSError+Helper.swift
//  Molnia
//
//  Created by Alex Shoshiashvili on 01.08.16.
//  Copyright © 2016 Alex Shoshiashvili. All rights reserved.
//

import Foundation

extension NSError {
  
  convenience init?(message: String) {
    var info: [String: AnyObject] = [:]
    info[NSLocalizedDescriptionKey] = message
    self.init(domain: "Molnia", code:  0, userInfo: info)
  }
  
}