//
//  RestaurantInfoTableViewCell.swift
//  DealWithMeal
//
//  Created by Alex Shoshiashvili on 26.11.16.
//  Copyright © 2016 Alex Shoshiashvili. All rights reserved.
//

import UIKit

class RestaurantInfoTableViewCell: UITableViewCell {
  
  var location = "1.12 km."
  var workTime = "10:00 — 19:00"
  var cuisineName = "Mexican"
  
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var workTimeLabel: UILabel!
  @IBOutlet weak var phoneLabel: UILabel!
  @IBOutlet weak var addressLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
