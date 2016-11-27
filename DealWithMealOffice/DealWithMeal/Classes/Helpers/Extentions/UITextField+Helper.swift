//
//  UITextField+Helper.swift
//
//  Created by Alex Shoshiashvili on 14.02.16.
//  Copyright © 2016 alexsho. All rights reserved.
//

import UIKit

enum ShakeDirection {
  case LeftToRight
  case RightToLeft
  
  func invert() -> ShakeDirection {
    if self == .LeftToRight {
      return .RightToLeft
    }
    return .LeftToRight
  }
}

extension UITextField {
  
  func setWhiteClearButton(viewMode viewMode: UITextFieldViewMode = .WhileEditing) {
    let clearButton = UIButton()
    clearButton.setImage(UIImage(named: "cross_big"), forState: UIControlState.Normal)
    clearButton.frame = CGRectMake(0, 0, 15, 15)
    self.rightView = clearButton
    self.rightViewMode = viewMode
  }
  
  func shake(times: Int, duration: Double, delta: CGFloat, direction: ShakeDirection, completion: (() -> ())? = nil) {
    
    let shakeDirection: CGFloat = direction == .LeftToRight ? 1 : -1
    
    UIView.animateWithDuration(duration - Double(times) * 0.01, delay: 0.01, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
      
      self.transform = CGAffineTransformMakeTranslation(delta * shakeDirection, 0)
      
      }) { (finished) -> Void in
        if (times > 0) {
          self.shake(times - 1, duration: duration, delta: delta, direction: direction.invert(), completion: completion)
        } else {
          self.transform = CGAffineTransformIdentity
          return;
        }
    }
  }
  
}
