//
//  Dish.swift
//  DealWithMeal
//
//  Created by Alex Shoshiashvili on 26.11.16.
//  Copyright © 2016 Alex Shoshiashvili. All rights reserved.
//

import UIKit

class Dish: NSObject {
  
  var id = 0
  var price = 100.0
  var name = ""
  var photo = ""
  var cusine = ""
  var type = ""
  
  convenience override init() {
    self.init([String:AnyObject]())
  }
  
  init (_ dictionary: [NSObject:AnyObject]) {
    
    if let nid = dictionary["id"] as? Int {
      id = nid
    }
    
    if let nprice = dictionary["price"] as? Double {
      price = nprice
    }
    
    if let nname = dictionary["name"] as? String {
      name = nname
    }
    
    if let nphoto = dictionary["photo"] as? String {
      photo = nphoto
    }
    
    if let ncusine = dictionary["cuisine"] as? String {
      cusine = ncusine
    }
    
    if let ntype = dictionary["type"] as? String {
      type = ntype
    }
    
    
  }
  
  
  
}