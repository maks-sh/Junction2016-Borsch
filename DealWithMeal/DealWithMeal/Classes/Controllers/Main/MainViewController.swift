//
//  MainViewController.swift
//
//  Created by Alex Shoshiashvili on 14.02.16.
//  Copyright © 2016 alexsho. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class MainViewController: UIViewController {
  
  // MARK: - User`s property
  
  var userId: Int {
    get {
      if let user = UserProfileData.sharedInstance.userData {
        return user.userId
      } else {
        return 0
      }
    }
  }
  
  var userToken: String {
    get {
      if let user = UserProfileData.sharedInstance.userData {
        return user.token
      } else {
        return "0"
      }
    }
  }
  
  // MARK: - VC Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: - Navigation bar
  
  func setupBackButton(toRoot : Bool = false, closeIcon: Bool = false) {
    let myBackButton = UIButton(type: .Custom)
    if toRoot {
      myBackButton.addTarget(self, action: #selector(MainViewController.popViewControllerToRoot), forControlEvents: UIControlEvents.TouchUpInside)
    } else {
      myBackButton.addTarget(self, action: #selector(MainViewController.popViewController), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    var iconName = "backIcon"
    if closeIcon {
      iconName = "closeIcon"
    }
    
    myBackButton.setImage(UIImage(named: iconName), forState: .Normal)
    myBackButton.sizeToFit()
    let myCustomBackButtonItem = UIBarButtonItem(customView: myBackButton)
    navigationItem.leftBarButtonItem  = myCustomBackButtonItem
  }
  
  func setupCloseBackButtonForDismiss() {
    let myBackButton = UIButton(type: .Custom)
    myBackButton.addTarget(self, action: #selector(MainViewController.dismissViewController), forControlEvents: UIControlEvents.TouchUpInside)
    let iconName = "closeIcon"
    myBackButton.setImage(UIImage(named: iconName), forState: .Normal)
    myBackButton.sizeToFit()
    let myCustomBackButtonItem = UIBarButtonItem(customView: myBackButton)
    navigationItem.leftBarButtonItem  = myCustomBackButtonItem
  }
  
  func popViewController() {
    navigationController?.popViewControllerAnimated(true)
  }
  
  func popViewControllerToRoot() {
    navigationController?.popToRootViewControllerAnimated(true)
  }
  
  func dismissViewController() {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  // MARK: - Get Some Data
  
  func getSolversOnlineCount(uiHandler: ((count: Int) -> ())?) {
    UsersSevices.onlineSolversCount { (error, count) in
      if error != nil {
        print(error?.localizedDescription)
      } else {
        uiHandler?(count: count!)
      }
    }
  }
  
  // MARK: - Helpers
  
  func changeStoryboad(storyboardName: StoryboardName) {
    GCDBlock.async(.Main) {
      let mainStoryboard: UIStoryboard = UIStoryboard(name: storyboardName.rawValue, bundle: nil)
      let viewController = mainStoryboard.instantiateViewControllerWithIdentifier(storyboardName.rawValue)
      viewController.modalTransitionStyle = .CrossDissolve
      self.presentViewController(viewController, animated: true, completion: { () -> Void in
//        self.stopActivityViewAnimating()
      })
    }
  }
  
  func showAlertWithMessage(message message: String?) {
    let alert = UIAlertController(title: nil, message: message ?? "No description", preferredStyle: .Alert)
    alert.addAction(UIAlertAction(title: "ОК", style: .Default, handler: nil))
    self.presentViewController(alert, animated: true, completion: nil)
  }
  
  func showAlertWithAction(action action: UIAlertAction, message: String) {
    let alertMessage = message
    let noTitle = "Нет"
    
    let yesAction = action
    let noAction = UIAlertAction(title: noTitle, style: .Cancel, handler: nil)
    
    let alert = UIAlertController(title: nil, message: alertMessage, preferredStyle: .Alert)
    alert.addAction(yesAction)
    alert.addAction(noAction)
    
    self.presentViewController(alert, animated: true, completion: nil)
  }
  
  // MARK: - Share Dialog
  
  func shareTextImageAndURL(textToShare textToShare: String?, sharingImage: UIImage?, sharingURL: NSURL?) {
    
    let subjectText = EngineRelatedConstants.shareAppName
    
    var itemToShare = [AnyObject]()
    
    if let text = textToShare {
      itemToShare.append(text)
    }
    if let image = sharingImage {
      itemToShare.append(image)
    }
    if let url = sharingURL {
      itemToShare.append(url)
    }
    
    let activityViewController = UIActivityViewController(activityItems: itemToShare, applicationActivities: nil)
    
    activityViewController.excludedActivityTypes = [UIActivityTypeAirDrop, UIActivityTypeAddToReadingList, UIActivityTypeSaveToCameraRoll, UIActivityTypePrint, UIActivityTypeAssignToContact]
    
    activityViewController.setValue(subjectText, forKey: "subject")
    
    self.presentViewController(activityViewController, animated: true, completion: nil)
    
  }
  
}

// MARK: - NVActivityIndicatorViewable

extension MainViewController: NVActivityIndicatorViewable {
  
  func startActivityViewAnimating(size: CGSize? = nil, type: NVActivityIndicatorType? = nil) {
    startActivityAnimating(size ?? CGSizeMake(50, 50), type: type ?? .Pacman)
  }
  
  func stopActivityViewAnimating() {
    stopActivityAnimating()
  }
  
}
