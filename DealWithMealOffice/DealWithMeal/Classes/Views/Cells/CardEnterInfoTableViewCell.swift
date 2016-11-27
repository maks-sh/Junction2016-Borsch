////
////  CardEnterInfoTableViewCell.swift
////  Molnia
////
////  Created by Alex Shoshiashvili on 10.09.16.
////  Copyright © 2016 Alex Shoshiashvili. All rights reserved.
////
//
//import UIKit
//
//class CardEnterInfoTableViewCell: UITableViewCell {
//  
//  @IBOutlet weak var cardInfoLabel: UILabel!
//  @IBOutlet weak var cardInfoTextField: AKMaskField!
//  override func awakeFromNib() {
//    super.awakeFromNib()
//    // Initialization code
//  }
//  
//  override func setSelected(selected: Bool, animated: Bool) {
//    super.setSelected(selected, animated: animated)
//  }
//  
//  func setupCellWithRow(row: Int, cardInfo : CardIOCreditCardInfo? = nil) {
//    cardInfoTextField.tag = row
//    switch row {
//    case 0:
//      let bulletSymbol = EngineRelatedConstants.bullet
//      let cardPlaceholder = "\(bulletSymbol)\(bulletSymbol)\(bulletSymbol)\(bulletSymbol) \(bulletSymbol)\(bulletSymbol)\(bulletSymbol)\(bulletSymbol) \(bulletSymbol)\(bulletSymbol)\(bulletSymbol)\(bulletSymbol) \(bulletSymbol)\(bulletSymbol)\(bulletSymbol)\(bulletSymbol)"
//      
//      cardInfoLabel.text = "Номер карты"
//      cardInfoTextField.placeholder = cardPlaceholder
//      cardInfoTextField.mask = "{dddd} {dddd} {dddd} {dddd}"
//      cardInfoTextField.maskTemplate = cardPlaceholder
//      
//      if let info = cardInfo {
//        cardInfoTextField.updateText(info.cardNumber)
//      }
//    case 1:
//      cardInfoLabel.text = "Истекает"
//      cardInfoTextField.placeholder = "мм / гг"
//      cardInfoTextField.mask = "{dd} / {dd}"
//      cardInfoTextField.maskTemplate = "мм / гг"
//      
//      if let info = cardInfo {
//        var yearString = String(info.expiryYear)
//        if yearString.characters.count == 4 {
//          yearString = yearString.dropFirstCharacter().dropFirstCharacter()
//        }
//        var monthString = String(info.expiryMonth)
//        if monthString.characters.count == 1 {
//          monthString = "0\(monthString)"
//        }
//        cardInfoTextField.updateText("\(monthString) / \(yearString)")
//      }
//    case 2:
//      cardInfoLabel.text = "CVC/CVV-код"
//      cardInfoTextField.placeholder = "Код безопасности"
//      cardInfoTextField.mask = nil
//      
//      if let info = cardInfo {
//        cardInfoTextField.text = info.cvv
//      }
//    default:
//      break
//    }
//    
//  }
//  
//}
