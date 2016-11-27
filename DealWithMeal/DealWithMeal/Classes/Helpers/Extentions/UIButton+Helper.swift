//
//  UIButton+Helper.swift
//
//  Created by Alex Shoshiashvili on 14.02.16.
//  Copyright © 2016 alexsho. All rights reserved.
//

import UIKit

enum ButtonType {
  case Filled
  case Stroked
}

extension UIButton {
  
  func makeRounded() {
    self.layer.cornerRadius = self.frame.size.height / 2.0
  }
  
  func roundedView() {
    self.layer.cornerRadius = self.frame.size.height / 2.0
    self.clipsToBounds = true
  }
  
  func defaultCornerButton() {
    self.layer.cornerRadius = Theme.buttons.defaultButtonCornerRadius()
    self.layer.masksToBounds = true
  }
  
  func defaultButton(withType type: ButtonType, color: UIColor) {
    if type == .Filled {
      self.setBackgroundImage(UIImage.imageWithColor(color, size: self.frame.size), forState: .Normal)
      self.setBackgroundImage(UIImage.imageWithColor(Theme.colors.defaultDisabledButtonColor(), size: self.frame.size), forState: .Disabled)
    } else {
      self.backgroundColor = .clearColor()
      self.layer.borderWidth = Theme.defaultBorderWidth()
      self.layer.borderColor = color.CGColor
      self.setTitleColor(color, forState: .Normal)
    }
    self.layer.cornerRadius = Theme.buttons.defaultButtonCornerRadius()
    self.clipsToBounds = true
  }
  
  func setColorToImage(color: UIColor, forState: UIControlState) {
    let origImage = self.imageView?.image
    let tintedImage = origImage?.imageWithRenderingMode(.AlwaysTemplate)
    self.setImage(tintedImage, forState: forState)
    self.tintColor = color
  }

}