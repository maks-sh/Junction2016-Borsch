//
//  Restaurant.swift
//  DealWithMeal
//
//  Created by Alex Shoshiashvili on 26.11.16.
//  Copyright © 2016 Alex Shoshiashvili. All rights reserved.
//

import UIKit

class Restaurant: NSObject {

  var coords = "55.643151,37.953269"
  var restDescription = ""
  var id = 1
  var name = ""
  var photos = [Photo]()
  var regime = "10:00-23:00"
  var dishes = [Dish]()
  
  var distance = ""
  var coordName = ""
  
  convenience override init() {
    self.init([String:AnyObject]())
  }
  
  init (_ dictionary: [NSObject:AnyObject]) {
    
    if let nregime = dictionary["regime"] as? String {
      regime = nregime
    }
    
    if let ncoords = dictionary["coords"] as? String {
      coords = ncoords
    }
    
    if let nrestDescription = dictionary["description"] as? String {
      restDescription = nrestDescription
    }
    
    if let nname = dictionary["name"] as? String {
      name = nname
    }
    
    if let nid = dictionary["id"] as? Int {
      id = nid
    }
    
    if let nphotos = dictionary["photos"] as? [[String: AnyObject]] {
      for photo in nphotos {
        photos.append(Photo(photo))
      }
    }
    
    if let ndishes = dictionary["dishes"] as? [[String: AnyObject]] {
      for dish in ndishes {
        dishes.append(Dish(dish))
      }
    }
    
  }
  
}
