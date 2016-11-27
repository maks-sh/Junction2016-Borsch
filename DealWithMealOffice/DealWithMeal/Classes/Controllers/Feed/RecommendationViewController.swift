//
//  RecommendationViewController.swift
//  DealWithMeal
//
//  Created by Alex Shoshiashvili on 27.11.16.
//  Copyright © 2016 Alex Shoshiashvili. All rights reserved.
//

import UIKit

class RecommendationViewController: UIViewController {
  @IBOutlet weak var secondTypeButton: UIButton!
  @IBOutlet weak var secondTextField: UITextField!
  @IBOutlet weak var thirdTextField: UITextField!
  
  @IBOutlet weak var bottomButtonConstraint: NSLayoutConstraint!
  
  var buttonLifted = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    secondTypeButton.roundView()
    
    thirdTextField.delegate = self
    
    setupNotifications()
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func setupNotifications() {
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(textFieldTextDidChange(_:)), name: UITextFieldTextDidChangeNotification, object: nil)
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
//      if changeInHeight > 0 {
        bottomButtonConstraint.constant += changeInHeight
//      } else {
//        bottomButtonConstraint.constant -= 75 //changeInHeight
//      }
      
      // TODO: Исправить
      if changeInHeight == 0 {
        bottomButtonConstraint.constant = 43
      }
      
      UIView.animateWithDuration(animationDurarion) {
        self.view.layoutIfNeeded()
      }
    }
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    view.endEditing(true)
  }
  
  // MARK: - Action
  
  @IBAction func firstTypeAction(sender: AnyObject) {
    
  }
  
  @IBAction func secondTypeAction(sender: AnyObject) {
    
  }
  
  @IBAction func thirdTypeAction(sender: AnyObject) {
    
  }
  
  
}

extension RecommendationViewController: DishesPickerViewControllerDelegate {
  func selectedDishes(dishes: [Dish]) {
    var idsString = ""
    
    for dish in dishes {
      idsString += "\(dish.id),"
    }
    idsString.dropLastCharacter()
    
    thirdTextField.text = idsString
    
  }
}

extension RecommendationViewController: UITextFieldDelegate {
  
  func textFieldTextDidChange(notification: NSNotification) {
    
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    return true
  }
  
  func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
    
    if textField.isEqual(thirdTextField) {
      let pickerVC = storyboard?.instantiateViewControllerWithIdentifier("Picker") as! DishesPickerViewController
//      presentViewController(pickerVC, animated: true, completion: nil)
      pickerVC.delegate = self
      navigationController?.pushViewController(pickerVC, animated: true)
    }
    
    return true
  }
  
}


