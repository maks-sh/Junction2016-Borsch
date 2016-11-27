//
//  URLManager.swift
//
//  Created by Alex Shoshiashvili on 14.02.16.
//  Copyright © 2016 alexsho. All rights reserved.
//

final class URLManager {
  static let sharedInstance = URLManager()
  private init() {}
}

/// External URLs

// MARK: - iTunes Connect App URLs

struct ItunesConstants {
  static let itunesAppURL = "itms-apps://itunes.apple.com/app/id\(EngineRelatedConstants.appID)"
  static let itunesAppSearchURL = "https://itunes.apple.com/lookup?id=\(EngineRelatedConstants.appID)"
  static let itunesAppRateURL = "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=\(EngineRelatedConstants.appID)&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software"
  static let itunesAppUpdateURL = "itms-apps://itunes.apple.com/app/bars/id\(EngineRelatedConstants.appID)"
}

/// API Paths

let baseDomainString = ""

struct APIConstants {
  static var baseURL = "http://188.166.65.99:8080/api"                           // API's Base URL
  
  // MARK: - Requests paths
  // MARK: - Authorization / Registration / Validation
  
  static let authSingInUrlPath = "/login"                                   // POST Sing In

  func resultUrl(urlPath: String) -> String {
    return APIConstants.baseURL + urlPath
  }
  
}