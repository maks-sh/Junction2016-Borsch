//
//  Dish.swift
//  DealWithMeal
//
//  Created by Alex Shoshiashvili on 26.11.16.
//  Copyright © 2016 Alex Shoshiashvili. All rights reserved.
//

import UIKit

class Dish: NSObject {
  
  convenience override init() {
    self.init([String:AnyObject]())
  }
  
  init (_ dictionary: [NSObject:AnyObject]) {
  }
  
}