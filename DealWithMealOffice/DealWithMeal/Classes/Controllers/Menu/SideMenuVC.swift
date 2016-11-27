//
//  SideMenuVC.swift
//
//  Created by Alex Shoshiashvili on 14.02.16.
//  Copyright © 2016 alexsho. All rights reserved.
//


import Foundation
import UIKit
import SlideMenuControllerSwift

enum MenuSectionNames : Int {
  case Profile = 0
  case Other = 1
}

struct menuItem {
  var title = ""
  var image = UIImage()
  var segue: String? = nil
  var filled = false
  
  init (_ title: String, _ image: UIImage, _ segue: SegueIdentifier? = nil, _ filled: Bool = false) {
    self.title = title
    self.image = image
    if let newSegue = segue {
      self.segue = newSegue.rawValue
    }
    self.filled = filled
  }
}

class SideMenuVC: UIViewController {
  
  let menuSections: [[menuItem]] = [
    [menuItem("List", UIImage(named:"catalog")!, nil),
      menuItem("Recommend", UIImage(named:"bookmarks")!, nil)
    ]
  ]
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var createTaskButton: UIButton!
  @IBOutlet weak var userView: UIView!
  @IBOutlet weak var logoutButton: UIButton!
  @IBOutlet weak var userIdLabel: UILabel!
  @IBOutlet weak var bookingsCountLabel: UILabel!
  @IBOutlet weak var lastBookingDateLabel: UILabel!
  @IBOutlet weak var promoCountLabel: UILabel!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  deinit {
    NSNotificationCenter.removeObserver(self)
  }
  
  // MARK: - Actions
  
  // MARK: Notification Actions
  func userUniversityDidChangedNotification() {
    let section = NSIndexSet(index: MenuSectionNames.Profile.rawValue)
    tableView.reloadSections(section, withRowAnimation: .None)
  }
  
  @IBAction func handleCreateTaskAction(sender: AnyObject) {
    performSegueWithIdentifier(.ShowCreateTaskViewController, sender: nil)
  }
  
  // MARK: - Segue
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  }
  
}

extension SideMenuVC: UITableViewDelegate, UITableViewDataSource {
  
  // MARK: UITableViewDataSource
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return menuSections.count
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return menuSections[section].count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//    let profileSideMenuCellIdentifier = "profileSideMenuCellIdentifier"
    let menuCellIdentifier = "menuCellIdentifier"
    
//    let sectionName = MenuSectionNames(rawValue: indexPath.section)!
    
    let cell = tableView.dequeueReusableCellWithIdentifier(menuCellIdentifier) as! MenuTableViewCell
    
    let item = menuSections[indexPath.section][indexPath.row]
    
    cell.iconImage.image = item.image
    cell.title.text = item.title
    
//    switch sectionName {
//    case .Profile:
//      let cell = tableView.dequeueReusableCellWithIdentifier(profileSideMenuCellIdentifier)!
//      return cell
//    case .Other:
//      let cell = tableView.dequeueReusableCellWithIdentifier(profileSideMenuCellIdentifier) as! MenuAccountTableViewCell
//      return cell
//    }
    
    return cell
    
  }
  
  // MARK: UITableViewDelegate
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    let item = menuSections[indexPath.section][indexPath.row]
    if let segue = item.segue {
      performSegueWithIdentifier(segue, sender: self)
    }
    
    switch indexPath.row {
    case 0:
      let feedVC = storyboard?.instantiateViewControllerWithIdentifier("Main") as! RestsFeedViewController
      slideMenuController()?.changeMainViewController(feedVC, close: true)
    case 1:
      let recommendVC = storyboard?.instantiateViewControllerWithIdentifier("Recommend") as! RecommendationViewController
      slideMenuController()?.changeMainViewController(recommendVC, close: true)
    default:
      break
    }
    
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    let sectionName = MenuSectionNames(rawValue: indexPath.section)!
    switch sectionName {
    case .Profile:
      return 46.0
    case .Other:
      return 46.0
    }
  }

}