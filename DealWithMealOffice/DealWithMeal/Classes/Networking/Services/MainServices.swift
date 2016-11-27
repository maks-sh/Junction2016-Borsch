//
//  MainServices.swift
//  Molnia
//
//  Created by Alex Shoshiashvili on 28.07.16.
//  Copyright © 2016 Alex Shoshiashvili. All rights reserved.
//

import UIKit
import Foundation

class MainServices {

  class var userId: Int {
    get {
      return Int(UserProfileData.sharedInstance.userId) ?? 1
    }
  }
  
  class var userToken: String {
    get {
      return UserProfileData.sharedInstance.userToken
    }
  }
  
  static let clientMutationId = NSUUID().UUIDString
  
}
