//
//  NSTimeInterval+Extension.swift
//
//  Created by Alex Shoshiashvili on 14.02.16.
//  Copyright © 2016 alexsho. All rights reserved.
//

import Foundation

extension NSTimeInterval {
  
  // Converting Interval (amount of seconds) to "HHH:MM:SS" format
  var toHoursMinutesSeconds: String {
    return String(format: "%lu:%02lu:%02lu", self / 3600, (self / 60) % 60, self % 60)
  }
  
  // Converting Interval (amount of seconds) to "DDD:HH:MM:SS" format
  var toDaysHoursMinutesSeconds: String {
    return String(format: "%d%@%02lu:%02lu:%02lu", self / 86400, "д. ", (self / 3600) % 24, (self / 60) % 60, self % 60)
  }
}