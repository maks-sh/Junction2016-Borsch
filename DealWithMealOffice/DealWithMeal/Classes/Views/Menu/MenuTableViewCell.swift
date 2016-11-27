//
//  MenuTableViewCell.swift
//
//  Created by Alex Shoshiashvili on 14.02.16.
//  Copyright © 2016 alexsho. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
  
  @IBOutlet weak var iconImage: UIImageView!
  @IBOutlet weak var title: UILabel!
  
  func setWithMenuItem(item: menuItem) {
    iconImage.image = item.image
    title.text = item.title
    title.textColor = Theme.colors.defaultBlackColor()
  }
}
