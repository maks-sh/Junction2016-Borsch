//
//  SummaryTableViewCell.swift
//  DealWithMeal
//
//  Created by Alex Shoshiashvili on 26.11.16.
//  Copyright © 2016 Alex Shoshiashvili. All rights reserved.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {
  
  @IBOutlet weak var countLabel: UILabel!
  @IBOutlet weak var subtotalLabel: UILabel!
  @IBOutlet weak var promoLabel: UILabel!
  @IBOutlet weak var totalLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
