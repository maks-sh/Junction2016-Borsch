//
//  RegisterViewController.swift
//  DealWithMeal
//
//  Created by Alex Shoshiashvili on 25.11.16.
//  Copyright © 2016 Alex Shoshiashvili. All rights reserved.
//

import UIKit

class RegisterViewController: MainAuthViewController {
  
  @IBOutlet weak var firstIndicator: UIImageView!
  @IBOutlet weak var secondIndicator: UIImageView!
  @IBOutlet weak var thirdIndicator: UIImageView!
  @IBOutlet weak var fourthIndicator: UIImageView!
  
  @IBOutlet weak var nameContainer: UIView!
  @IBOutlet weak var phoneContainer: UIView!
  @IBOutlet weak var emailContainer: UIView!
  @IBOutlet weak var passwordContainer: UIView!
  
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var phoneTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  
  @IBOutlet weak var continueButton: UIButton!
  @IBOutlet weak var backButton: UIButton!
  
  @IBOutlet weak var containerView: UIView!
  
  @IBOutlet weak var bottomButtonConstraint: NSLayoutConstraint!
  
  let nameText = "Name"
  let phoneText = "Phone"
  let emailText = "Email"
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
  
  // MARK: - Setups
  
  private func setupViews() {
    
    navigationController?.navigationBarHidden = true
    
    nameContainer.roundView()
    phoneContainer.roundView()
    emailContainer.roundView()
    passwordContainer.roundView()
    continueButton.defaultCornerButton()
    
    nameTextField.delegate = self
    phoneTextField.delegate = self
    emailTextField.delegate = self
    passwordTextField.delegate = self
    
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
        bottomButtonConstraint.constant = 36
      }
      
      UIView.animateWithDuration(animationDurarion) {
        self.view.layoutIfNeeded()
      }
    }
  }
  
  // MARK: - Actions
  
  @IBAction func handleBackAction(sender: AnyObject) {
//    navigationController?.popViewControllerAnimated(true)
    dismissViewController()
  }
  
  @IBAction func handleContinueAction(sender: AnyObject) {
    
    AuthServices.singUp(withPhone: phoneTextField.text!, email: emailTextField.text!, password: passwordTextField.text!) { (error, userProfile) in
      if error != nil {
        self.showAlertWithMessage(message: error?.localizedDescription)
      } else {
        let feedNavVC = self.storyboard?.instantiateViewControllerWithIdentifier("FeedNav") as! UINavigationController
        self.presentViewController(feedNavVC, animated: true, completion: nil)
      }
    }
    
  }
  
  @IBAction func handleTermsAndConditionsAction(sender: AnyObject) {
    
  }
  
}

extension RegisterViewController: UITextFieldDelegate {
  
  func textFieldTextDidChange(notification: NSNotification) {
    if isSignInCorrect() {
      continueButton.enabled = true
    } else {
      continueButton.enabled = false
    }
  }
  
  func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
    
    if textField.text == nameText || textField.text == phoneText || textField.text == emailText || textField.text == passwordText {
      textField.text = ""
    }
    
    if textField.isEqual(nameTextField) {
      changeIndicatorState(1)
    } else if textField.isEqual(phoneTextField) {
      changeIndicatorState(2)
    } else if textField.isEqual(emailTextField) {
      changeIndicatorState(3)
    } else if textField.isEqual(passwordTextField) {
      changeIndicatorState(4)
    }
    
    return true
  }
  
  func textFieldDidEndEditing(textField: UITextField) {
    if textField.text == "" {
      if textField.isEqual(nameTextField) {
        nameTextField.text = nameText
      } else if textField.isEqual(phoneTextField) {
        phoneTextField.text = phoneText
      } else if textField.isEqual(emailTextField) {
        emailTextField.text = emailText
      } else {
        passwordTextField.text = passwordText
      }
    }
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    // unselectedIndicator
    if textField.isEqual(nameTextField) {
      phoneTextField.becomeFirstResponder()
      changeIndicatorState(2)
    } else if textField.isEqual(phoneTextField) {
      emailTextField.becomeFirstResponder()
      changeIndicatorState(3)
    } else if textField.isEqual(emailTextField) {
      passwordTextField.becomeFirstResponder()
      changeIndicatorState(4)
    } else if textField.isEqual(passwordTextField) {
      textField.resignFirstResponder()
    } else {
      textField.resignFirstResponder()
    }
    
    return true
  }
  
  // MARK: - Helpers
  
  func changeIndicatorState(selectedIndicator: Int) {
    let selectedImage = UIImage(named: "selectedIndicator")
    let unselectedImage = UIImage(named: "unselectedIndicatorDot")
    switch selectedIndicator {
    case 1:
      firstIndicator.image = selectedImage
      secondIndicator.image = unselectedImage
      thirdIndicator.image = unselectedImage
      fourthIndicator.image = unselectedImage
    case 2:
      firstIndicator.image = unselectedImage
      secondIndicator.image = selectedImage
      thirdIndicator.image = unselectedImage
      fourthIndicator.image = unselectedImage
    case 3:
      firstIndicator.image = unselectedImage
      secondIndicator.image = unselectedImage
      thirdIndicator.image = selectedImage
      fourthIndicator.image = unselectedImage
    case 4:
      firstIndicator.image = unselectedImage
      secondIndicator.image = unselectedImage
      thirdIndicator.image = unselectedImage
      fourthIndicator.image = selectedImage
    default:
      break
    }
  }
  
  func isSignInCorrect() -> Bool {
    
    guard let nameText = nameTextField.text where !nameText.isEmpty else {
      // Name fail
      return false
    }
    
    guard let emailText = emailTextField.text where !emailText.isEmpty && emailText.isValidEmail() else {
      // Email fail
      return false
    }
    
    guard let passwordText = passwordTextField.text where !(passwordText.characters.count  < 6) else {
      // Password fail
      return false
    }
    
    guard let phone = phoneTextField.text where !(phone.characters.count  < 6) else {
      // Retype Password fail
      return false
    }
    
    return true
    
  }
  
  
}