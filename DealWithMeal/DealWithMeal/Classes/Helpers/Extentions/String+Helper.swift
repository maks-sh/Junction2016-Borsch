//
//  String+Helper.swift
//
//  Created by Alex Shoshiashvili on 14.02.16.
//  Copyright © 2016 alexsho. All rights reserved.
//
import Foundation

extension String {
  
  func isValidEmail() -> Bool {
    let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluateWithObject(self)
  }
  
  func isValidTimeString() -> Bool {
    let timeRegEx = "^(([0,1][0-9])|(2[0-3])):[0-5][0-9]"
    
    let timeTest = NSPredicate(format: "SELF MATCHES %@", timeRegEx)
    return timeTest.evaluateWithObject(self)
  }
  
  func isValidNumber() -> Bool {
    let numberRegEx = "^[0-9]*$"
    
    let numberTest = NSPredicate(format: "SELF MATCHES %@", numberRegEx)
    return numberTest.evaluateWithObject(self)
    
  }
  
  func isValidDate() -> Bool {
    let dateRegEx = "^([0-3][0-9]).([0|1][0-9]).([0-9]{4})"
    
    let dateTest = NSPredicate(format: "SELF MATCHES %@", dateRegEx)
    return dateTest.evaluateWithObject(self)
  }
  
  // MARK: - Date
  
  func convertToDate() -> NSDate {
    
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    dateFormatter.timeZone = NSTimeZone(name: "UTC")
    let date = dateFormatter.dateFromString(self)
    
    if let resultDate = date {
      return resultDate
    } else {
      print("convertToDate error")
      return NSDate()
    }
  }
  
  func converToDateFromShortDateString() -> NSDate {
    
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "dd.MM.yyyy"
    dateFormatter.timeZone = NSTimeZone(name: "UTC")
    let date = dateFormatter.dateFromString(self)
    
    return date!
  }
  
  func converToTime() -> Int {
    
    var departureTime = 0
    
    let intArray = self.characters.filter({ Int(String($0)) != nil }).map({ Int(String($0))! })
    
    departureTime += (intArray[0] * 10 + intArray[1]) * 60
    departureTime += (intArray[2] * 10 + intArray[3])
    
    return departureTime
  }
  
  func convertToDateFromTimeInterval() -> NSDate {
    let timeInterval = Double(self)
    let date = NSDate(timeIntervalSince1970: timeInterval ?? 0.0)
    return date
  }
  
  // MARK: - 
  
  func isNumeric() -> Bool {
    let scanner = NSScanner(string: self)
    scanner.locale = NSLocale.currentLocale()
    return scanner.scanDecimal(nil) && scanner.atEnd
  }
  
  func stringByTrimmingLeadingAndTrailingWhitespace() -> String {
    let leadingAndTrailingWhitespacePattern = "^\\s+([^\\s]*)\\s+$"
    if let regex = try? NSRegularExpression(pattern: leadingAndTrailingWhitespacePattern, options: .CaseInsensitive) {
      let range = NSMakeRange(0, self.characters.count)
      let trimmedString = regex.stringByReplacingMatchesInString(self, options: .ReportProgress, range:range, withTemplate:"$1")
      return trimmedString
    } else {
      return self
    }
  }
  
  var URLEncoded: String {
    let unreservedChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~"
    let unreservedCharset = NSCharacterSet(charactersInString: unreservedChars)
    let encodedString = self.stringByAddingPercentEncodingWithAllowedCharacters(unreservedCharset)
    return encodedString ?? self
  }
  
  // MARK: - Change string
  
  func dropLastCharacter() -> String {
    return substringToIndex(self.endIndex.predecessor())
  }
  
  func dropFirstCharacter() -> String {
    return substringFromIndex(self.startIndex.successor())
  }
  
  // MARK: - Currency
  
  func stringWithRubleSymbol() -> String {
    return self + " \(EngineRelatedConstants.ruble)"
  }
  
  // MARK: - Work with Phone string
  
  func digitsOnly() -> String{
    let stringArray = self.componentsSeparatedByCharactersInSet(
      NSCharacterSet.decimalDigitCharacterSet().invertedSet)
    let newString = stringArray.joinWithSeparator("")
    return newString
  }
  
//
//  func addNumber(inputNumber: Int) -> String {
//    var currentString = self
//    let number = "\(inputNumber)"
//    
//    if currentString.characters.count == 0 {
//      currentString = "+7 ("
//    }
//    
//    if currentString.characters.count >= 4 && currentString.characters.count < 7 {
//      currentString = currentString + number
//    } else if currentString.characters.count == 7 {
//      currentString = currentString + ") " + number
//    } else if currentString.characters.count > 8 && currentString.characters.count < 12 {
//      currentString = currentString + number
//    } else if currentString.characters.count == 12 {
//      currentString = currentString + "-" + number
//    } else if currentString.characters.count > 12 && currentString.characters.count < 15 {
//      currentString = currentString + number
//    } else if currentString.characters.count == 15 {
//      currentString = currentString + "-" + number
//    } else if currentString.characters.count > 16 && currentString.characters.count < 18 {
//      currentString = currentString + number
//    }
//    
//    return currentString
//  }
//  
//  func deleteNumber() -> String {
//    
//    if self.characters.count == 0 {
//      return ""
//    }
//    
//    var currentString = self
//    let lastCharacter = self.characters.last
//    
//    if lastCharacter == "(" {
//      return ""
//    }
//    
//    currentString = currentString.dropLastCharacter()
//    let previousLastCharacter = currentString.characters.last
//    
//    if previousLastCharacter == "-" {
//      currentString = currentString.dropLastCharacter()
//    } else if previousLastCharacter == ")" || previousLastCharacter == " " {
//      currentString = currentString.dropLastCharacter()
//      currentString = currentString.dropLastCharacter()
//    }
//    
//    return currentString
//  }
  
  
  
}