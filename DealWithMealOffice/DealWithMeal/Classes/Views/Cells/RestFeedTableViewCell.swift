//
//  RestFeedTableViewCell.swift
//  DealWithMeal
//
//  Created by Alex Shoshiashvili on 25.11.16.
//  Copyright © 2016 Alex Shoshiashvili. All rights reserved.
//

import UIKit

class RestFeedTableViewCell: UITableViewCell {
  
  @IBOutlet weak var restImageView: UIImageView!
  @IBOutlet weak var restDecription: UILabel! // name
  @IBOutlet weak var restDistance: UILabel! // price
  @IBOutlet weak var restCuisineType: UILabel!
  
//  var isSelected = false
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
