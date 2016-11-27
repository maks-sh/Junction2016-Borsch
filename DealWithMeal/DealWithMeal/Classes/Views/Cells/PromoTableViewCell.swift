//
//  PromoTableViewCell.swift
//  DealWithMeal
//
//  Created by Alex Shoshiashvili on 26.11.16.
//  Copyright © 2016 Alex Shoshiashvili. All rights reserved.
//

import UIKit

class PromoTableViewCell: UITableViewCell {
  
  @IBOutlet weak var promoImageView: UIImageView!
  @IBOutlet weak var fullDescription: UILabel!
  @IBOutlet weak var shortDescription: UILabel!
  @IBOutlet weak var restName: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
