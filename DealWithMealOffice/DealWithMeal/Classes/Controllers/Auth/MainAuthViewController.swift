//
//  MainAuthViewController.swift
//  Molnia
//
//  Created by Alex Shoshiashvili on 30.07.16.
//  Copyright © 2016 Alex Shoshiashvili. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class MainAuthViewController: MainViewController {
  
  var buttonLifted = false
  
  // MARK: - VC Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = Theme.colors.defaultAuthBackgroundColor()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return .LightContent
  }
  
  func setupButtonHighlightColor(buttons: [UIButton]) {
    for button in buttons {
      button.setBackgroundImage(UIImage(named: "selectedKeyboardButton"), forState: .Highlighted)
    }
  }
  
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    view.endEditing(true)
  }
  
}