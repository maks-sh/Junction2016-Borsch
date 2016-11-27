//
//  CartViewController.swift
//  DealWithMeal
//
//  Created by Alex Shoshiashvili on 26.11.16.
//  Copyright © 2016 Alex Shoshiashvili. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var saveBarButton: UIBarButtonItem!
  
  var dishesArray = [Dish]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  @IBAction func handleSaveAction(sender: AnyObject) {
  }
  
  // summaryCellIdentifier
  
  // positionCellIdentifier
  
}

extension CartViewController : UITableViewDelegate, UITableViewDataSource {
  
  // MARK: - UITableViewDataSource
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dishesArray.count + 1
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let positionCellIdentifier = "positionCellIdentifier"
    let summaryCellIdentifier = "summaryCellIdentifier"
    
    if indexPath.row < dishesArray.count {
      let position = dishesArray[indexPath.row]
      
      let cell = tableView.dequeueReusableCellWithIdentifier(positionCellIdentifier) as! PositionTableViewCell
      
      return cell
    } else {
      let cell = tableView.dequeueReusableCellWithIdentifier(summaryCellIdentifier) as! SummaryTableViewCell
      return cell
    }
    
  }
  
  // MARK: UITableViewDelegate
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    if indexPath.row < dishesArray.count {
      return 80
    } else {
      return 80
    }
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
  
  // MARK: Helper
}
