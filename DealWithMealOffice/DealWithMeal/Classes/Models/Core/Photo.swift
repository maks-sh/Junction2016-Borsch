//
//  Photo.swift
//  Molnia
//
//  Created by Alex Shoshiashvili on 03.08.16.
//  Copyright © 2016 Alex Shoshiashvili. All rights reserved.
//

import UIKit

class Photo: NSObject {
  
  var photo = ""
  var id = ""
  
  var photoUrl : NSURL? {
    return NSURL(string: photo)
  }
  
  var thumbPhotoUrl : NSURL? {
    return NSURL(string: photo)
  }
  
  convenience override init() {
    self.init([String:AnyObject]())
  }
  
  init (_ dictionary: [NSObject:AnyObject]) {
    
    if let newId = dictionary["id"] as? String {
      id = newId
    }
    
    if let newUrl = dictionary["photo"] as? String {
//      let clearNewUrl = newUrl.stringByReplacingOccurrencesOfString("\\", withString: "")
      photo = newUrl
    }    
  }
  
}
