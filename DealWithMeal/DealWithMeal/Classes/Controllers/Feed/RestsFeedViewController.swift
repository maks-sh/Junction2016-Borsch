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
  
  var restsArray = [Restaurant]()
  
  var locationManager = CLLocationManager()
  var didFindMyLocation = false
  var myCLLocation = CLLocation()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    locationManager.delegate = self
    locationManager.requestWhenInUseAuthorization()
    
    title = "Restaurants"
    
    startActivityViewAnimating()
    
    let myLocationCoordinate = myCLLocation.coordinate
    let coords = "\(myLocationCoordinate.latitude),\(myLocationCoordinate.longitude)"
    
//    RestServices.restaurantsWithCoordinates(coords) { (error, restaurants) in
//      self.stopActivityViewAnimating()
//      if error != nil {
//        print("blyat")
//        self.showAlertWithMessage(message: error?.localizedDescription)
//      } else {
//        self.restsArray = restaurants!
//        
//        for rest in self.restsArray {
//          self.geocodeAndDistance(rest.coords, handler: { (coordName, distance) in
//            rest.distance = "\(Int(distance / 1000) ?? 0).\(Int(distance - Int(distance)) ?? 0) km."
//            rest.coordName = coordName
//            self.tableView.reloadData()
//          })
//        }
//      }
//    }
    
    loadRestaurants()
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.estimatedRowHeight = 90.0
    tableView.rowHeight = UITableViewAutomaticDimension
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  func loadRestaurants() {
    RestServices.restaurants { (error, restaurants) in
      self.stopActivityViewAnimating()
      if error != nil {
        print("blyat")
      } else {
        self.restsArray = restaurants!
        
        for rest in self.restsArray {
          self.geocodeAndDistance(rest.coords, handler: { (coordName, distance) in
            let km = "\(Int(distance / 1000) ?? 0)"
            let m = "\(Int(distance - Double(Int(distance) ?? 0)) ?? 0)"
            rest.distance = km + "." + m + " km."
            rest.coordName = coordName
            self.tableView.reloadData()
          })
        }
      }
    }
  }
  
  // MARK: - Data
  
  func filterContentForSearchText(searchText: String) {
//    if self.restsArray.count == 0 {
//      self.restsArraySearchResults = []
//      return
//    }
//    
//    RestServices.restaurantsWithName(searchText) { (error, restaurants) in
//      
//      if error != nil {
//        self.showAlertWithMessage(message: error?.localizedDescription)
//      } else {
//        self.restsArraySearchResults = restaurants!
//        
//        for rest in self.restsArraySearchResults {
//          self.geocodeAndDistance(rest.coords, handler: { (coordName, distance) in
//            let km = "\(Int(distance / 1000) ?? 0)"
//            let m = "\(Int(distance - Double(Int(distance) ?? 0)) ?? 0)"
//            rest.distance = km + "." + m + " km."
//            rest.coordName = coordName
//            self.tableView.reloadData()
//          })
//        }
//        
//      }
//      
//    }
  }
  
  // MARK: - CLLocationManagerDelegate
  
  func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
    if status == CLAuthorizationStatus.AuthorizedWhenInUse {
      
    }
  }
  
  // MARK: - KVO
  
  override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
    if !didFindMyLocation {
      let myLocation: CLLocation = change![NSKeyValueChangeNewKey] as! CLLocation
      myCLLocation = myLocation
      didFindMyLocation = true
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
  
  
  func geocodeAndDistance(coord: String, handler:((coordName: String, distance: Double) -> ())) {
    
    let coords = coord.componentsSeparatedByString(",")
    let lat = coords.first
    let long = coords.last
    
    let restPointLocation = CLLocation(latitude: Double(lat ?? "54.3") ?? 54.3, longitude: Double(long ?? "23.1") ?? 23.1)
    
    let distance = GMSGeometryDistance(myCLLocation.coordinate, restPointLocation.coordinate)
    
    let geoCoder:CLGeocoder = CLGeocoder()
    geoCoder.reverseGeocodeLocation(restPointLocation, completionHandler: { (placemarks:[CLPlacemark]?, error:NSError?) -> Void in
      if placemarks != nil {
        if placemarks?.count > 0 {
          
          let placemark = placemarks!.first!
          
          var routePointName = ""
          if placemark.subThoroughfare != nil {
            routePointName += "\(placemark.subThoroughfare!), "
          }
          if placemark.thoroughfare != nil {
            routePointName += "\(placemark.thoroughfare!), "
          }
          if placemark.administrativeArea != nil {
            routePointName += "\(placemark.administrativeArea!), "
          }
          if placemark.country != nil {
            routePointName += "\(placemark.country!)"
          }
          
          handler(coordName: routePointName, distance: distance)
          
        } else {
          
          
          
          handler(coordName: "", distance: distance)
          
        }
      } else {
        handler(coordName: "", distance: distance)
      }
      
    })
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
    return restsArray.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let restFeedCellIdentifier = "restFeedCellIdentifier"
    let cell = tableView.dequeueReusableCellWithIdentifier(restFeedCellIdentifier) as! RestFeedTableViewCell
    let rest = restsArray[indexPath.row]
    
    //      cell.configurateCellWithRest(rest: rest)
    
    let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
    activityIndicatorView.center = cell.restImageView.center
    activityIndicatorView.hidesWhenStopped = true
    cell.restImageView.addSubview(activityIndicatorView)
    activityIndicatorView.startAnimating()
    
    cell.restImageView.sd_setImageWithURL(NSURL(string: rest.photos.first?.photo ?? "http://gred-tea.com.ua/images/Skolko_kalorij_v_raznih_borshah.jpg")!) { (image, error, cacheType, url) in
      activityIndicatorView.removeFromSuperview()
    }
    
    cell.restDistance.text = rest.distance
    cell.restDecription.text = rest.name
    cell.restCuisineType.text = rest.regime
    
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
    let rest = restsArray[indexPath.row]
    let restVC = storyboard?.instantiateViewControllerWithIdentifier("Restaurant") as! RestaurantViewController
    restVC.restaurant = rest
    restVC.myCLLocation = myCLLocation
    navigationController?.pushViewController(restVC, animated: true)
    //    parentNavigationController?.pushViewController(taskVC, animated: true)
    //    performSegueWithIdentifier(.ShowTaskViewController, sender: selectedTask)
  }
  
  // MARK: Helper
  
  func getIndex(indexPath: NSIndexPath) -> Int {
    let index = round(Double(indexPath.row) / 2.0)
    return Int(index)
  }
  
}
