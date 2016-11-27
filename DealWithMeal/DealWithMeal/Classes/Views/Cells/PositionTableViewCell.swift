//
//  PositionTableViewCell.swift
//  DealWithMeal
//
//  Created by Alex Shoshiashvili on 26.11.16.
//  Copyright © 2016 Alex Shoshiashvili. All rights reserved.
//

import UIKit

class PositionTableViewCell: UITableViewCell {
  
  @IBOutlet weak var positionImageView: UIImageView!
  @IBOutlet weak var positionNameLabel: UILabel!
  @IBOutlet weak var existLabel: UILabel!
  @IBOutlet weak var quantityLabel: UILabel!
  @IBOutlet weak var quantityStepper: UIStepper!
  @IBOutlet weak var priceLabel: UILabel!
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  // MARK: - Actions
  
  @IBAction func handleStepperChangeValueAction(sender: AnyObject) {
    
  }
}
