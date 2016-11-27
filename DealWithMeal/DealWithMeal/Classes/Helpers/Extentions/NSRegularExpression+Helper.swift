//
//  NSRegularExpression+Helper.swift
//  Molnia
//
//  Created by Alex Shoshiashvili on 30.07.16.
//  Copyright © 2016 Alex Shoshiashvili. All rights reserved.
//

import Foundation

struct SearchOptions {
  let searchString: String
  var replacementString: String?
  let matchCase: Bool
  let wholeWords: Bool
}

extension NSRegularExpression {

  convenience init?(options: SearchOptions) {
    let searchString = options.searchString
    let isCaseSensitive = options.matchCase
    let isWholeWords = options.wholeWords
    
    let regexOption: NSRegularExpressionOptions = (isCaseSensitive) ? [] : .CaseInsensitive
    
    let pattern = (isWholeWords) ? "\\b\(searchString)\\b" : searchString
    
    try? self.init(pattern: pattern, options: regexOption)
  }
  
  class func regularExpressionForDates() -> NSRegularExpression? {
    let pattern = "(\\d{1,2}[-/.]\\d{1,2}[-/.]\\d{1,2})|(Jan(uary)?|Feb(ruary)?|Mar(ch)?|Apr(il)?|May|Jun(e)?|Jul(y)?|Aug(ust)?|Sep(tember)?|Oct(ober)?|Nov(ember)?|Dec(ember)?)\\s*(\\d{1,2}(st|nd|rd|th)?+)?[,]\\s*\\d{4}"
    return try? NSRegularExpression(pattern: pattern, options: .CaseInsensitive)
  }
  
  class func regularExpressionForTimes() -> NSRegularExpression? {
    let pattern = "\\d{1,2}\\s*(pm|am)"
    return try? NSRegularExpression(pattern: pattern, options: .CaseInsensitive)
  }
  
  class func regularExpressionForLocations() -> NSRegularExpression? {
    let pattern = "[a-zA-Z]+[,]\\s*([A-Z]{2})"
    return try? NSRegularExpression(pattern: pattern, options: [])
  }
  
  class func regularExpressionForEmail() -> NSRegularExpression? {
    let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
    return try? NSRegularExpression(pattern: pattern, options: [])
  }
  
  class func regularExpressionForPhone() -> NSRegularExpression? {
    let pattern = "^\\d{3}-\\d{3}-\\d{4}$"
    return try? NSRegularExpression(pattern: pattern, options: [])
  }
  
  
}