//
//  UIView+Helper.swift
//
//  Created by Alex Shoshiashvili on 14.02.16.
//  Copyright © 2016 alexsho. All rights reserved.
//

import UIKit

extension UIView {
  
  // To load view from nib
  class func loadFromNibNamed(nibNamed: String, bundle : NSBundle? = nil) -> UIView? {
    return UINib(nibName: nibNamed, bundle: bundle).instantiateWithOwner(nil, options: nil)[0] as? UIView
  }
  
  // Apply default shadow settings from Theme
  func applyDefaultThemeShadow() {
    addShadow(shadowOpacity: 0.35, shadowOffset: CGSizeMake(1.0, 1.0), shadowRadius: 0.5)
  }
  
  // Sets shadow parameters to the view's layer
  // For round views method creates additional view for shadow i.e. cornerRadius and shadow couldn't be mixed
  func addShadow(shadowOpacity shadowOpacity: Float = 0.0, shadowOffset: CGSize = CGSizeMake(0.0, 2.0), shadowRadius: CGFloat = 3.0, shadowColor: UIColor = UIColor.blackColor()) -> UIView? {
    let cornerRadius = layer.cornerRadius
    if  cornerRadius > 0.0 && layer.masksToBounds == true && superview != nil {
      let shadowView = UIView(frame: frame)
      shadowView.tag = 4321
      shadowView.backgroundColor = UIColor.clearColor()
      shadowView.addShadow(shadowOpacity: shadowOpacity, shadowOffset: shadowOffset, shadowRadius: shadowRadius, shadowColor: shadowColor)
      shadowView.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).CGPath
      shadowView.layer.masksToBounds = true
      shadowView.clipsToBounds = false
      
      if let oldView = superview!.viewWithTag(4321) {
        oldView.removeFromSuperview()
      }
      
      superview!.insertSubview(shadowView, belowSubview: self)
      
//      shadowView.snp_makeConstraints{ (make) -> Void in
//        make.left.right.top.bottom.equalTo(self)
//      }
      
      return shadowView
    } else {
      layer.shadowOpacity = shadowOpacity
      layer.shadowOffset = shadowOffset
      layer.shadowRadius = shadowRadius
      layer.shadowColor = shadowColor.CGColor
      layer.shadowPath = UIBezierPath(roundedRect: frame, cornerRadius: shadowRadius).CGPath
    }
    return nil
  }
  
  // Add blured Subview to self
  func addBlurEffect(style: UIBlurEffectStyle) {
    let blurEffect = UIBlurEffect(style: style)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.tag = 1414
    blurEffectView.frame = self.bounds
    
    self.insertSubview(blurEffectView, atIndex: 0)
  }
  
  // Enable/Disable userInterationProperty for all subviews including self
  private func setRecursiveUserInteractionEnabled(value: Bool) {
    
    self.userInteractionEnabled = value
    for view in self.subviews {
      view.userInteractionEnabled = value
    }
  }
  
  func roundView() {
    self.layer.cornerRadius = self.frame.size.height/2
    self.clipsToBounds = true
  }
  
  func roundViewWithRadius(radius: CGFloat) {
    self.layer.cornerRadius = radius
    self.clipsToBounds = true
  }
  
  // Find first responder
  
  func currentFirstResponder() -> UIView? {
    if self.isFirstResponder() {
      return self
    }
    
    for view in self.subviews {
      if let responder = view.currentFirstResponder() {
        return responder
      }
    }
    
    return nil
  }
  
  // MARK: - Size func
  
  func setX(x: CGFloat) {
    var frame:CGRect = self.frame
    frame.origin.x = x
    self.frame = frame
  }
  
  func setY(y: CGFloat) {
    var frame:CGRect = self.frame
    frame.origin.y = y
    self.frame = frame
  }
  
  func setWidth(width: CGFloat) {
    var frame:CGRect = self.frame
    frame.size.width = width
    self.frame = frame
  }
  
  func setHeight(height: CGFloat) {
    var frame:CGRect = self.frame
    frame.size.height = height
    self.frame = frame
  }
  
  // MARK: - Animation
  
  func startRotateAnimating(speed: Float = 0.75) {
    let duration: CFTimeInterval = 0.75
    
    //    Scale animation
    let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
    scaleAnimation.keyTimes = [0, 0.5, 1]
    
    // Rotate animation
    let rotateAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
    
    rotateAnimation.keyTimes = scaleAnimation.keyTimes
    rotateAnimation.values = [0, M_PI, 2 * M_PI]
    
    // Animation
    let animation = CAAnimationGroup()
    
    animation.animations = [rotateAnimation]
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    animation.duration = duration
    animation.repeatCount = HUGE
    animation.removedOnCompletion = false
    
    self.layer.addAnimation(animation, forKey: "animation")
    self.layer.speed = speed
  }
  
  // MARK: - Capture
  
  func capture() -> UIImage {
    
    UIGraphicsBeginImageContextWithOptions(self.frame.size, self.opaque, UIScreen.mainScreen().scale)
    self.layer.renderInContext(UIGraphicsGetCurrentContext()!)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image
  }
  
}