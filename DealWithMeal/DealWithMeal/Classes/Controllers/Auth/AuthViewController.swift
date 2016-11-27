//
//  AuthViewController.swift
//  DealWithMeal
//
//  Created by Alex Shoshiashvili on 25.11.16.
//  Copyright © 2016 Alex Shoshiashvili. All rights reserved.
//

import UIKit

class AuthViewController: MainAuthViewController {
  
  @IBOutlet weak var logoImageView: UIImageView!
  @IBOutlet weak var usernameContainerView: UIView!
  @IBOutlet weak var passwordContainerView: UIView!
  @IBOutlet weak var usernameIcon: UIImageView!
  @IBOutlet weak var passwordIcon: UIImageView!
  @IBOutlet weak var usernameTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  
  @IBOutlet weak var getStartButton: UIButton!
  @IBOutlet weak var createAccountButton: UIButton!
  @IBOutlet weak var needHelpButton: UIButton!
  
  @IBOutlet weak var containerView: UIView!
  
  @IBOutlet weak var bottomButtonConstraint: NSLayoutConstraint!
  
  let usernameText = "Username"
  let passwordText = "Password"
  
  // MARK: - VC Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupNotifications()
  }
  
  override func viewWillAppear(animated: Bool) {
    navigationController?.navigationBarHidden = true
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.navigationBarHidden = false
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Setup
  
  private func setupViews() {
    
    navigationController?.navigationBarHidden = true
    
    usernameContainerView.roundView()
    passwordContainerView.roundView()
    
    usernameContainerView.bringSubviewToFront(usernameIcon)
    passwordContainerView.bringSubviewToFront(passwordIcon)
    
    usernameTextField.delegate = self
    passwordTextField.delegate = self
    
    getStartButton.roundView()
  }
  
  func setupNotifications() {
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    
//    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(textFieldTextDidChange(_:)), name: UITextFieldTextDidChangeNotification, object: nil)
  }
  
  // MARK: - Button lifting
  
  func keyboardWillShow(notification:NSNotification) {
    adjustingHeight(true, notification: notification)
  }
  
  func keyboardWillHide(notification:NSNotification) {
    adjustingHeight(false, notification: notification)
  }
  
  func adjustingHeight(show:Bool, notification:NSNotification) {
    if !(show && buttonLifted) {
      buttonLifted = show
      var userInfo = notification.userInfo!
      let keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
      let animationDurarion = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSTimeInterval
      let changeInHeight = CGRectGetHeight(keyboardFrame) * (show ? 1 : -1)
      if changeInHeight > 0 {
        bottomButtonConstraint.constant += 75 //changeInHeight
      } else {
        bottomButtonConstraint.constant -= 75 //changeInHeight
      }
      
      // TODO: Исправить
      if changeInHeight == 0 {
        bottomButtonConstraint.constant = 43
      }
      
      UIView.animateWithDuration(animationDurarion) {
        self.view.layoutIfNeeded()
      }
    }
  }
  
  // MARK: - Actions
  
  @IBAction func handleGetStartedAction(sender: AnyObject) {
    AuthServices.signIn(phone: usernameTextField.text!, password: passwordTextField.text!) { (error, userProfile) in
      if error != nil {
        self.showAlertWithMessage(message: error?.localizedDescription)
      } else {
        let feedNavVC = self.storyboard?.instantiateViewControllerWithIdentifier("FeedNav") as! UINavigationController
        self.presentViewController(feedNavVC, animated: true, completion: nil)
      }
    }
  }
  
  @IBAction func handleCreateAccountAction(sender: AnyObject) {
//      secondVC.transitioningDelegate = self
//      self.presentViewController(secondVC, animated: true, completion: nil)
  }
  
  @IBAction func handleNeedHelpAction(sender: AnyObject) {
  }
  
}

extension AuthViewController: UITextFieldDelegate {
  
  func textFieldTextDidChange(notification: NSNotification) {
    if isSignInCorrect() {
      getStartButton.enabled = true
    } else {
      getStartButton.enabled = false
    }
  }
  
  func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
    
    if textField.text == usernameText || textField.text == passwordText {
      textField.text = ""
    }
    
    return true
  }
  
  func textFieldDidEndEditing(textField: UITextField) {
    if textField.text == "" {
      if textField.isEqual(usernameTextField) {
        usernameTextField.text = usernameText
      } else {
        passwordTextField.text = passwordText
      }
    }
  }
  
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    if textField.isEqual(usernameTextField) {
      passwordTextField.becomeFirstResponder()
    } else {
      if isSignInCorrect() {
        textField.resignFirstResponder()
//        signInAction(UIButton())
      }
    }
    return true
  }
  
  // MARK: - Helpers
  
  func isSignInCorrect() -> Bool {
    
    guard let usernameText = usernameTextField.text where !usernameText.isEmpty else {
      // Email fail
      return false
    }
    
    guard let passwordText = passwordTextField.text where !passwordText.isEmpty else {
      // Password fail
      return false
    }
    
    return true
    
  }
  
}
