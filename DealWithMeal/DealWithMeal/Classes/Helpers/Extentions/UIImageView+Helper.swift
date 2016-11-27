//
//  UIImageView+Helper.swift
//  Molnia
//
//  Created by Alex Shoshiashvili on 12.09.16.
//  Copyright © 2016 Alex Shoshiashvili. All rights reserved.
//

import UIKit

extension UIImageView {
  
  func blurImage() {
    let blurEffect = UIBlurEffect(style: .ExtraLight)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = self.bounds
    blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    self.addSubview(blurEffectView)
  }
  
}
