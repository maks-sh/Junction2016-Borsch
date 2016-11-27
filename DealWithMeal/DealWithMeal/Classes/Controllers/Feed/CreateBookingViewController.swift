//
//  CreateBookingViewController.swift
//  DealWithMeal
//
//  Created by Alex Shoshiashvili on 26.11.16.
//  Copyright © 2016 Alex Shoshiashvili. All rights reserved.
//

import UIKit

class CreateBookingViewController: UIViewController {
  
  @IBOutlet weak var timesCollectionView: UICollectionView!
  @IBOutlet weak var seatsCountStepper: UIStepper!
  @IBOutlet weak var seatsCountLabel: UILabel!
  @IBOutlet weak var bookButton: UIButton!
  @IBOutlet weak var cartBarButton: UIBarButtonItem!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Actions
  
  @IBAction func handleStepperChangeValueAction(sender: AnyObject) {
    
  }
  
  @IBAction func handleBookAction(sender: AnyObject) {
    
  }
  
  // timeCollectionCellIdentifier
  
}
