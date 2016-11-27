//
//  Array+Helper.swift
//  Molnia
//
//  Created by Alex Shoshiashvili on 24.08.16.
//  Copyright © 2016 Alex Shoshiashvili. All rights reserved.
//

import Foundation

extension Array where Element : Equatable {
  mutating func removeObject(object : Generator.Element) {
    if let index = self.indexOf(object) {
      self.removeAtIndex(index)
    }
  }
}