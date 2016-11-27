//
//  EntranceViewController.swift
//  Molnia
//
//  Created by Alex Shoshiashvili on 30.07.16.
//  Copyright © 2016 Alex Shoshiashvili. All rights reserved.
//

import UIKit

class EntranceViewController: MainViewController {
  
  @IBOutlet weak var dealWithMeal: UIImageView!
  @IBOutlet weak var upToTopConstraint: NSLayoutConstraint!
  
  // MARK: - VC Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    

    setupViews()
    
//    GCDBlock.after(.Main, delay: 3.0) {
//      self.chooseRootView()
//    }
    
  }
  
  override func viewWillAppear(animated: Bool) {
    navigationController?.navigationBarHidden = true
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.navigationBarHidden = false
  }
  
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    var oldFrame = dealWithMeal.frame
    oldFrame.origin.y = 90
    let newFrame = oldFrame
    
    
    UIView.animateWithDuration(1.5,
                               delay: 0.0,
                               options: .CurveEaseInOut,
                               animations: {
         self.dealWithMeal.frame = newFrame
      }) { (finishing) in
        self.upToTopConstraint.constant = 70
    }
    
    GCDBlock.after(.Main, delay: 2.0) {
      self.chooseRootView()
    }
    
  }
  
  func setupViews() {
    navigationController?.navigationBarHidden = true
  }
  
  func chooseRootView() {
    let userAuthState = UserProfileData.sharedInstance.userState
    
    switch userAuthState {
    case .Authorized:
      break
//      performSegueWithIdentifier(.ShowAuthorize, sender: self)
    case .NotAuthorized:
      break
//      performSegueWithIdentifier(.ShowAuthorize, sender: self)
    case .TokenExpired:
      print("sad")
      break
//      performSegueWithIdentifier(.ShowAuthorize, sender: self)
      
      //      NSNotificationCenter.postNotification(.TokenExpiredNotification)
      //      performSegueWithIdentifier(.ShowMainApp, sender: self)
    }
    
    let authVC = storyboard?.instantiateViewControllerWithIdentifier("Auth") ?? AuthViewController()
    presentViewController(authVC, animated: false) {
    }
    
  }
  
  // MARK: - Segue
  
//  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//    if segue.destinationViewController is AuthViewController {
//      let destVC = segue.destinationViewController as! AuthViewController
//    } else if segue.destinationViewController is CardPreviewViewController {
//      let destVC = segue.destinationViewController as! CardPreviewViewController
//      let screenshot = sender as! UIImage
//      destVC.backgroundImage = screenshot
//    }
//  }
  
}