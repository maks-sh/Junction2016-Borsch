//
//  BookingsViewController.swift
//  DealWithMeal
//
//  Created by Alex Shoshiashvili on 26.11.16.
//  Copyright © 2016 Alex Shoshiashvili. All rights reserved.
//

import UIKit

class BookingsViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  
  var bookingsArray = [Task]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    bookingsArray.append(Task())
    bookingsArray.append(Task())
    bookingsArray.append(Task())
    bookingsArray.append(Task())
    bookingsArray.append(Task())
    
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

extension BookingsViewController : UITableViewDelegate, UITableViewDataSource {
  
  // MARK: - UITableViewDataSource
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return bookingsArray.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let bookingCellIdentifier = "bookingCellIdentifier"
    
    let booking = bookingsArray[indexPath.row]
    
    let cell = tableView.dequeueReusableCellWithIdentifier(bookingCellIdentifier) as! BookingTableViewCell
    cell.statusImageView.image = UIImage(named: "backIcon")
    cell.restName.text = "Tili-tili"
    cell.timeLabel.text = "10:40"
    cell.statusLable.text = "Pending"
    
    return cell
    
  }
  
  // MARK: UITableViewDelegate
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return  70
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
  
  // MARK: Helper
  
  
}