//
//  RestsFeedViewController.swift
//  DealWithMeal
//
//  Created by Alex Shoshiashvili on 25.11.16.
//  Copyright © 2016 Alex Shoshiashvili. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
import NVActivityIndicatorView
import SDWebImage
import GoogleMaps

class RestsFeedViewController: SlideMenuController, CLLocationManagerDelegate {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var menuBarButtonItem: UIBarButtonItem!
  @IBOutlet weak var settingsBarButtonItem: UIBarButtonItem!
  
  var dishesArray = [Dish]()
  
  var locationManager = CLLocationManager()
  var didFindMyLocation = false
  var myCLLocation = CLLocation()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    locationManager.delegate = self
    locationManager.requestWhenInUseAuthorization()
    
    title = "Menu"
    
    loadRestaurant()
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.estimatedRowHeight = 90.0
    tableView.rowHeight = UITableViewAutomaticDimension
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  func loadRestaurant() {
    startActivityViewAnimating()
    
    RestServices.restaurantById(restId: "1") { (error, restaurantById) in
      self.stopActivityViewAnimating()
      if error != nil {
        print("blyat")
      } else {
        self.dishesArray = restaurantById!.dishes
        self.tableView.reloadData()
      }
    }
    
  }
  
  // MARK: - Actions
  
  @IBAction func handleMenuAction(sender: AnyObject) {
    self.slideMenuController()?.openLeft()
  }
  
  @IBAction func handleSettingsAction(sender: AnyObject) {
  }
  
  func showAlertWithMessage(message message: String?) {
    let alert = UIAlertController(title: nil, message: message ?? "No description", preferredStyle: .Alert)
    alert.addAction(UIAlertAction(title: "ОК", style: .Default, handler: nil))
    self.presentViewController(alert, animated: true, completion: nil)
  }
  
  func showAlertWithAction(action action: UIAlertAction, message: String) {
    let alertMessage = message
    let noTitle = "Нет"
    
    let yesAction = action
    let noAction = UIAlertAction(title: noTitle, style: .Cancel, handler: nil)
    
    let alert = UIAlertController(title: nil, message: alertMessage, preferredStyle: .Alert)
    alert.addAction(yesAction)
    alert.addAction(noAction)
    
    self.presentViewController(alert, animated: true, completion: nil)
  }
  
}

// MARK: - NVActivityIndicatorViewable

extension RestsFeedViewController: NVActivityIndicatorViewable {
  
  func startActivityViewAnimating(size: CGSize? = nil, type: NVActivityIndicatorType? = nil) {
    startActivityAnimating(size ?? CGSizeMake(50, 50), type: type ?? .Pacman)
  }
  
  func stopActivityViewAnimating() {
    stopActivityAnimating()
  }
  
}

extension RestsFeedViewController : UITableViewDelegate, UITableViewDataSource {
  
  // MARK: - UITableViewDataSource
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dishesArray.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let restFeedCellIdentifier = "restFeedCellIdentifier"
    let cell = tableView.dequeueReusableCellWithIdentifier(restFeedCellIdentifier) as! RestFeedTableViewCell
    let dish = dishesArray[indexPath.row]
    
    let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
    activityIndicatorView.center = cell.restImageView.center
    activityIndicatorView.hidesWhenStopped = true
    cell.restImageView.addSubview(activityIndicatorView)
    activityIndicatorView.startAnimating()

    cell.restImageView.sd_setImageWithURL(NSURL(string: dish.photo ?? "http://gred-tea.com.ua/images/Skolko_kalorij_v_raznih_borshah.jpg")!) { (image, error, cacheType, url) in
      activityIndicatorView.removeFromSuperview()
    }
    
    cell.restDecription.text = dish.name
    cell.restDistance.text = "\(dish.price)"
    cell.restCuisineType.text = dish.cusine
    
    return cell
    
  }
  
  // MARK: UITableViewDelegate
  
  func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 90.0
  }
  
  //  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
  //      return 90
  //  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
  
}
