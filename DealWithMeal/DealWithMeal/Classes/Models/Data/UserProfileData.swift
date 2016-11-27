//
//  UserProfileData.swift
//
//  Created by Alex Shoshiashvili on 14.02.16.
//  Copyright © 2016 alexsho. All rights reserved.
//

import Foundation

class UserProfileData {
  
  static let sharedInstance = UserProfileData()
  
  private var userProfile: UserProfile = UserProfile()
  
  enum UserAuthState {
    case Authorized
    case NotAuthorized
    case TokenExpired
  }
  
  var userData: UserProfile? {
    get {
      if let profileDict = UserDefaultsManager.cachedUserProfileDict {
        let user = UserProfile(profileDict)
        return user
      } else {
        return userProfile
      }
    }
    set {
      userProfile = newValue ?? UserProfile()
      UserDefaultsManager.cachedUserProfileDict = newValue?.writeJson["userProfile"]
    }
  }
  
  private init() {
  }
  
  var userState: UserAuthState {
    get {
      if let user = userData {
        if (user.userId > 0 && user.token.characters.count > 0) {
//        if (user.userId.characters.count > 0 && user.token.characters.count > 0) {
          return .Authorized
        } else if (user.userId > 0) {
          return .TokenExpired
        }
        return .NotAuthorized
      } else {
        return .NotAuthorized
      }
    }
  }
  
  var isSignedUp: Bool {
    get {
      if let token = userData?.token {
        return token.characters.count > 0 ? true : false
      } else {
        return false
      }
    }
  }
  
  var userId: Int {
    get {
      if let user = userData {
        return user.userId
      } else {
        return 0
      }
    }
  }
  
  var userToken: String {
    get {
      if let user = userData {
        return user.token
      } else {
        return "0"
      }
    }
  }
  
}