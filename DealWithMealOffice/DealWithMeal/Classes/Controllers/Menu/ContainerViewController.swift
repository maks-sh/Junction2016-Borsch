//
//  ContainerViewController.swift
//  DealWithMeal
//
//  Created by Alex Shoshiashvili on 25.11.16.
//  Copyright © 2016 Alex Shoshiashvili. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class ContainerViewController: SlideMenuController {
  
  @IBOutlet weak var menuBarButtonItem: UIBarButtonItem!
  @IBOutlet weak var settingsBarButtonItem: UIBarButtonItem!
  
  override func awakeFromNib() {
    if let controller = self.storyboard?.instantiateViewControllerWithIdentifier("Main") {
      self.mainViewController = controller
    }
    if let controller = self.storyboard?.instantiateViewControllerWithIdentifier("Left") {
      self.leftViewController = controller
    }
    super.awakeFromNib()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Actions
  
  @IBAction func handleMenuAction(sender: AnyObject) {
    self.slideMenuController()?.openLeft()
  }
  
  @IBAction func handleSettingsAction(sender: AnyObject) {
  }
  
}
