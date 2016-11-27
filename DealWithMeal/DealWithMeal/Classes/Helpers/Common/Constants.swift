//
//  Constants.swift
//
//  Created by Alex Shoshiashvili on 14.02.16.
//  Copyright © 2016 alexsho. All rights reserved.
//

import UIKit

// MARK: - Social Network

struct SocialNetworkUrl {
  let scheme: String
  let page: String
  
  func openPage(id: String) {
    let schemeUrl = NSURL(string: scheme + id)!
    if UIApplication.sharedApplication().canOpenURL(schemeUrl) {
      UIApplication.sharedApplication().openURL(schemeUrl)
    } else {
      UIApplication.sharedApplication().openURL(NSURL(string: page + id)!)
    }
  }
}

enum SocialNetwork: String {
  case VK = "vk"
  case Facebook = "facebook"
  case FB = "fb"
  case GooglePlus = "google"
  case Twitter = "twitter"
  case Telegram = "telegram"
  case WhatsApp = "whatsApp"
  
  func url() -> SocialNetworkUrl {
    switch self {
    case .FB:
      return SocialNetworkUrl(scheme: "fb://profile/", page: "https://www.facebook.com/")
    case .Facebook:
      return SocialNetworkUrl(scheme: "fb://profile/", page: "https://www.facebook.com/")
    case .Twitter:
      return SocialNetworkUrl(scheme: "twitter:///user?user_id=", page: "https://twitter.com/intent/user?user_id=")
    case .GooglePlus:
      return SocialNetworkUrl(scheme: "gplus://plus.google.com/u/0/", page: "https://plus.google.com/")
    case .VK:
      return SocialNetworkUrl(scheme: "vk://vk.com/id", page:"https://vk.com/id")
    case .Telegram:
      return SocialNetworkUrl(scheme: "tg//:resolve?domain=", page: "https://telegram.me/")
    case .WhatsApp:
      return SocialNetworkUrl(scheme: "whatsapp://send?text=", page: "whatsapp://send?text=")
    }
  }
  
  func openPage(withId id: String) {
    self.url().openPage(id)
  }
  
}


// MARK: - Screen Size Constants

struct ScreenSizeConstants {
  static let screenBounds = UIScreen.mainScreen().bounds
  static let screenWidth = screenBounds.size.width
  static let screenHeight = screenBounds.size.height
  
  static let cellSize = screenWidth * 0.94
  
  static var screenStatusBarHeight: CGFloat {
    return UIApplication.sharedApplication().statusBarFrame.height
  }
  
  static let screenMainInset = UIApplication.sharedApplication().statusBarFrame.height + 44.0
  
  static let miniOffset: CGFloat = 5.0
  static let smallOffset: CGFloat = 10.0
  static let midOffset: CGFloat = 15.0
  
  static let cornerRadius: CGFloat = 4.0
  static let avatarLargeSize = 248
}

// MARK: - Global Notification Constants

struct GlobalNotificationConstants {
  static let splashScreenJobDone = "SplashScreenJobDoneNotification"
}

enum GlobalNotificationConstant: String {
  case TokenExpiredNotification = "TokenExpiredNotification"
  case TaskCreatedNotification = "TaskCreatedNotification"
  case TaskDeletedNotification = "TaskDeletedNotification"
  case TaskApproveSolutionNotification = "TaskApproveSolutionNotification"
  case TaskDeniedSolutionNotification = "TaskDeniedSolutionNotification"
  case TaskTakedInWorkNotification = "TaskTakedInWorkNotification"
  case UserUniversityDidChangedNotification = "UserUniversityDidChangedNotification"
}

// MARK: - Segue

struct SegueIdentifierConstants {
  static let showMainApp = "showMainApp"
  static let showTeamsSelect = "showTeamsSelect"
  
  static let showEventsList = "showEventsList"
  static let showEventsCal = "showEventsCal"
  static let showMyEvents = "showMyEvents"
  static let showSettings = "showSettings"
  static let showAbout = "showAbout"
}

enum SegueIdentifier: String {
  // Basical
  case ShowAuthorize = "showAuthorize"
  case ShowMainApp = "ShowMainApp"
  case ShowAuth = "ShowAuthViewController"
  case ShowOnboarding = "ShowOnboarding"
  
  // Auth
  case ShowEnterCodeViewController = "ShowEnterCodeViewController"
  
  // Main
  case ShowTasksViewController = "ShowTasksViewController"
  case ShowTaskViewController = "ShowTaskViewController"
  case ShowTaskArbitrationReasonViewController = "ShowTaskArbitrationReasonViewController"
  case ShowCreateTaskViewController = "ShowCreateTaskViewController"
  case ShowProfileViewController = "ShowProfileViewController"
  case ShowCardViewController = "ShowCardViewController"
  case ShowCardPreviewViewController = "ShowCardPreviewViewController"
  case ShowCardEnterInfoViewController = "ShowCardEnterInfoViewController"
  case ShowUniversityViewController = "ShowUniversityViewController"
  case ShowFeedbackViewController = "ShowFeedbackViewController"
}


// MARK: - Storyboard`s name

enum StoryboardName: String {
  case Main = "Main"
  case Auth = "Auth"
  case Onboarding = "Onboarding"
}

// MARK: - Device Related Constants

enum DeviceHeight: CGFloat {
  case Inches_3_5 = 480
  case Inches_4 = 568
  case Inches_4_7 = 667
  case Inches_5_5 = 736
}

// MARK: - Engine Related Constants

struct EngineRelatedConstants {
  
  static let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
  
  static let ruble = "\u{20BD}" // Ruble symble
  static let space = "\u{00A0}" // Space symbol
  static let bullet = "\u{2022}" // Bullet symbol
  
  // MARK: - Share App Name
  static let shareAppName = "Молния"
  
  // MARK: - Errors
  static let errorDomain = ""
  
  // MARK: - iTunes Connect App ID
  static let appID = ""      // Current AppId
  
  // MARK: - Social Network App ID
  static let vkAppID = ""
  static let googlePlusAppID = ""
  static let googleMapKey = "AIzaSyC2HpdM_HymYKwqxJ8AWM0CVQJxWtERVNc"
  static let googleMapGeocodeKey = "AIzaSyAkaravbNyusvtwIZKzxvQpCt8YkDUIEOA"
  
  // MARK: - Directories
  static let documentDirectoryPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
  
//   MARK: - Syncano
//
//  static let syncanoApiKey = "b611f6964c2fa4b0d2b7f9a70e99bd47c2d83c7b"
//  static let syncanoInstance = "molnia"
  
}

struct ExpirationTimeIntervals {
  static var urgent : Double =  60 * 60
  static var oneDay : Double = urgent * 24
  static var oneWeek : Double = oneDay * 7
}

struct ExpirationNames {
  static var urgent : String =  "Срочно"
  static var oneDay : String = "Один день"
  static var oneWeek : String = "Одна неделя"
}

struct ExpirationPrices {
  static var urgent : Float =  149
  static var oneDay : Float = 199
  static var oneWeek : Float = 249
}
