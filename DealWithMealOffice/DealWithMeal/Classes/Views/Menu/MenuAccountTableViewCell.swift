//
//  MenuAccountTableViewCell.swift
//  Molnia
//
//  Created by Alex Shoshiashvili on 26.08.16.
//  Copyright © 2016 Alex Shoshiashvili. All rights reserved.
//

import UIKit

protocol MenuAccountTableViewCellDelegate {
  func refillAccount(cell : MenuAccountTableViewCell)
}

class MenuAccountTableViewCell: UITableViewCell {
  
  @IBOutlet weak var accountLabel: UILabel!
  @IBOutlet weak var refillAccountButton: UIButton!
  
  var delegate : MenuAccountTableViewCellDelegate?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    refillAccountButton.defaultCornerButton()
  }
  
  // MARK: - Actions
  
  @IBAction func handleRefillAccountAction(sender: AnyObject) {
    delegate?.refillAccount(self)
  }
}
