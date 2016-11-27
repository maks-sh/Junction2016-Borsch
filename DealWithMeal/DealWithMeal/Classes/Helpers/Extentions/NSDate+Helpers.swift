//
//  NSDate+Helpers.swift
//
//  Created by Alex Shoshiashvili on 14.02.16.
//  Copyright © 2016 alexsho. All rights reserved.
//

import UIKit

extension NSDate {
  
  //format of order time header
  
  func eventTimeString() -> String {
    
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "dd.MM | HH:mm"
    
    return dateFormatter.stringFromDate(self)
    
  }
  
  func eventCardTimeString() -> String {
    
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "dd MMMM, HH:mm"
    
    return dateFormatter.stringFromDate(self)
    
  }
  
  func shortTimeString() -> String {
    
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "dd.MM.yyyy"
    
    return dateFormatter.stringFromDate(self)
    
  }
  
  func hourAndMinutesTimeString() -> String {
    
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    
    return dateFormatter.stringFromDate(self)
    
  }
  
  func fullTimeString() -> String {
      
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    dateFormatter.timeZone = NSTimeZone(name: "UTC")
    return dateFormatter.stringFromDate(self)
    
  }
  
  func willBeDoneToDateString() -> String {
    let now = NSDate()
    let daysTo = now.daysTo(self)
    let dateFormatter = NSDateFormatter()
    
    if daysTo > 0 {
      switch daysTo {
      case 1:
        dateFormatter.dateFormat = "завтра к HH:mm"
      default:
        dateFormatter.dateFormat = "dd.MM к HH:mm"
      }
    } else {
      dateFormatter.dateFormat = "сегодня к HH:mm"
    }
    
    return dateFormatter.stringFromDate(self)
  }
  
  func willBeArbitrationToDateString() -> String {
    let now = NSDate()
    let daysTo = now.daysTo(self)
    let dateFormatter = NSDateFormatter()
    
    if daysTo > 0 {
      switch daysTo {
      case 1:
        dateFormatter.dateFormat = "завтра HH:mm"
      default:
        dateFormatter.dateFormat = "dd.MM HH:mm"
      }
    } else {
      dateFormatter.dateFormat = "HH:mm"
    }
    
    return dateFormatter.stringFromDate(self)
  }
  
  func arbitrationDateString() -> String {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "dd MMM yyyy HH:mm"
    return dateFormatter.stringFromDate(self)
  }
  
  func answerDateString() -> String {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "dd MMM yyyy в HH:mm"
    return dateFormatter.stringFromDate(self)
  }
  
  func formattedFromCompenents(styleAttitude: NSDateFormatterStyle, year: Bool = true, month: Bool = true, day: Bool = true, hour: Bool = true, minute: Bool = true, second: Bool = true) -> String {
    let long = styleAttitude == .LongStyle || styleAttitude == .FullStyle ? true : false
    var comps = ""
    
    if year { comps += long ? "yyyy" : "yy" }
    if month { comps += long ? "MMMM" : "MMM" }
    if day { comps += long ? "dd" : "d" }
    
    if hour { comps += long ? "HH" : "H" }
    if minute { comps += long ? "mm" : "m" }
    if second { comps += long ? "ss" : "s" }
    
    let format = NSDateFormatter.dateFormatFromTemplate(comps, options: 0, locale: NSLocale.currentLocale())
    let formatter = NSDateFormatter()
    formatter.dateFormat = format
    return formatter.stringFromDate(self)
  }
  
  func secondsFrom(date:NSDate) -> Int {
    return NSCalendar.currentCalendar().components(.Second, fromDate: date, toDate: self, options: []).second
  }
  
  
  func yearsFrom(date:NSDate) -> Int {
    return NSCalendar.currentCalendar().components(.Year, fromDate: date, toDate: self, options: NSCalendarOptions()).year
  }
  func monthsFrom(date:NSDate) -> Int {
    return NSCalendar.currentCalendar().components(.Month, fromDate: date, toDate: self, options: NSCalendarOptions()).month
  }
  func weeksFrom(date:NSDate) -> Int {
    return NSCalendar.currentCalendar().components(.WeekOfYear, fromDate: date, toDate: self, options: NSCalendarOptions()).weekOfYear
  }
  func daysFrom(date:NSDate) -> Int {
    return NSCalendar.currentCalendar().components(.Day, fromDate: date, toDate: self, options: NSCalendarOptions()).day
  }
  func hoursFrom(date:NSDate) -> Int {
    return NSCalendar.currentCalendar().components(.Hour, fromDate: date, toDate: self, options: NSCalendarOptions()).hour
  }
  func minutesFrom(date:NSDate) -> Int {
    return NSCalendar.currentCalendar().components(.Minute, fromDate: date, toDate: self, options: NSCalendarOptions()).minute
  }
  func daysTo(date:NSDate) -> Int {
    return NSCalendar.currentCalendar().components(.Day, fromDate: self, toDate: date, options: NSCalendarOptions()).day
  }
  
  var relativeTime: String {
    let now = NSDate()
    if now.yearsFrom(self) > 0 {
      return now.yearsFrom(self).description  + " год"  + { return now.yearsFrom(self)   > 1 ? "" : "" }() + " назад"
    }
    if now.monthsFrom(self) > 0 {
      return now.monthsFrom(self).description + " месяц" + { return now.monthsFrom(self)  > 1 ? "ев" : "" }() + " назад"
    }
    if now.weeksFrom(self) > 0 {
      return now.weeksFrom(self).description  + " недель"  + { return now.weeksFrom(self)   > 1 ? "ь" : "я" }() + " назад"
    }
    if now.daysFrom(self) > 0 {
      if now.daysFrom(self) == 1 { return "Вчера" }
      return now.daysFrom(self).description + " дней назад"
    }
    return "Сегодня"
  }
  
}

func > (lhs: NSDate, rhs: NSDate) -> Bool {
  return lhs.timeIntervalSinceReferenceDate > rhs.timeIntervalSinceReferenceDate
}

func < (lhs: NSDate, rhs: NSDate) -> Bool {
  return lhs.timeIntervalSinceReferenceDate < rhs.timeIntervalSinceReferenceDate
}

func >= (lhs: NSDate, rhs: NSDate) -> Bool {
  return (lhs.timeIntervalSinceReferenceDate > rhs.timeIntervalSinceReferenceDate) || (lhs == rhs)
}

func <= (lhs: NSDate, rhs: NSDate) -> Bool {
  return (lhs.timeIntervalSinceReferenceDate < rhs.timeIntervalSinceReferenceDate) || (lhs == rhs)
}