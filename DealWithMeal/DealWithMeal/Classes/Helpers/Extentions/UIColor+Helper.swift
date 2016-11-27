//
//  UIColor+Helper.swift
//
//  Created by Alex Shoshiashvili on 14.02.16.
//  Copyright © 2016 alexsho. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
  
  convenience init(red: Int, green: Int, blue: Int) {
    assert(red >= 0 && red <= 255, "Invalid red component")
    assert(green >= 0 && green <= 255, "Invalid green component")
    assert(blue >= 0 && blue <= 255, "Invalid blue component")
    
    self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
  }
  
  convenience init(netHex: Int) {
    self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
  }
  
  convenience init(hexString: String) {
    var hex = hexString
    
    if hex.hasPrefix("#") {
      hex = hex.substringFromIndex(hex.startIndex.advancedBy(1))
    }
    
    if (hex.rangeOfString("(^[0-9A-Fa-f]{6}$)|(^[0-9A-Fa-f]{3}$)", options: .RegularExpressionSearch) != nil) {
      
      if hex.characters.count == 3 {
        let redHex   = hex.substringToIndex(hex.startIndex.advancedBy(1))
        let greenHex = hex.substringWithRange(Range<String.Index>(start: hex.startIndex.advancedBy(1), end: hex.startIndex.advancedBy(2)))
        let blueHex  = hex.substringFromIndex(hex.startIndex.advancedBy(2))
        
        hex = redHex + redHex + greenHex + greenHex + blueHex + blueHex
      }
      
      let redHex = hex.substringToIndex(hex.startIndex.advancedBy(2))
      let greenHex = hex.substringWithRange(Range<String.Index>(start: hex.startIndex.advancedBy(2), end: hex.startIndex.advancedBy(4)))
      let blueHex = hex.substringWithRange(Range<String.Index>(start: hex.startIndex.advancedBy(4), end: hex.startIndex.advancedBy(6)))
      
      var redInt:   CUnsignedInt = 0
      var greenInt: CUnsignedInt = 0
      var blueInt:  CUnsignedInt = 0
      
      NSScanner(string: redHex).scanHexInt(&redInt)
      NSScanner(string: greenHex).scanHexInt(&greenInt)
      NSScanner(string: blueHex).scanHexInt(&blueInt)
      
      self.init(red: CGFloat(redInt) / 255.0, green: CGFloat(greenInt) / 255.0, blue: CGFloat(blueInt) / 255.0, alpha: 1.0)
    } else {
      self.init()
    }
  }
  
  class func colorFromRGBValue(rgbValue: UInt) -> UIColor {
    return UIColor(
      red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
      alpha: CGFloat(1.0)
    )
  }
}