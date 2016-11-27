//
//  RestaurantViewController.swift
//  DealWithMeal
//
//  Created by Alex Shoshiashvili on 26.11.16.
//  Copyright © 2016 Alex Shoshiashvili. All rights reserved.
//

import UIKit
import SDWebImage
import GoogleMaps

enum RestaurantInfo: Int {
  case Images = 0
  case Info = 1
  case Description = 2
  case Dishes = 3
  case Book = 4
}

class RestaurantViewController: MainViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var myCLLocation = CLLocation()
  var restaurant = Restaurant()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    startActivityViewAnimating()
    RestServices.restaurantById(restId: "\(restaurant.id)") { (error, restaurantById) in
      self.stopActivityViewAnimating()
      if error != nil {
        self.showAlertWithMessage(message: error?.localizedDescription)
      } else {
        self.restaurant = restaurantById!
//        self.title = self.restaurant.name
        
        self.geocodeAndDistance(self.restaurant.coords, handler: { (coordName, distance) in
          let km = "\(Int(distance / 1000) ?? 0)"
          let m = "\(Int(distance - Double(Int(distance) ?? 0)) ?? 0)"
          self.restaurant.distance = km + "." + m + " km."
          self.restaurant.coordName = coordName
          self.tableView.reloadData()
        })
      }
    }
    
    tableView.dataSource = self
    tableView.delegate = self
    tableView.estimatedRowHeight = 44.0
    tableView.rowHeight = UITableViewAutomaticDimension
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
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

extension RestaurantViewController : UITableViewDelegate, UITableViewDataSource {
  
  // MARK: - UITableViewDataSource
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let restImagesCellIdentifier = "restImagesCellIdentifier"
    let restInfoCellIdentifier = "restInfoCellIdentifier"
    let restDescriptionCellIdentifier = "restDescriptionCellIdentifier"
    let restDishesCellIdentifier = "restDishesCellIdentifier"
    let restBookCellIdentifier = "restBookCellIdentifier"
    
    let restaurantInfo = RestaurantInfo(rawValue: indexPath.row)!
    switch restaurantInfo {
    case .Images:
      let cell = tableView.dequeueReusableCellWithIdentifier(restImagesCellIdentifier) as! RestaurantImagesTableViewCell
      
      let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
      activityIndicatorView.center = cell.restImageView.center
      activityIndicatorView.hidesWhenStopped = true
      cell.restImageView.addSubview(activityIndicatorView)
      activityIndicatorView.startAnimating()
      cell.restImageView.sd_setImageWithURL(NSURL(string: restaurant.photos.first?.photo ?? "http://promotime.me/images/categories/going_out.jpg")) { (image, error, cacheType, url) in
        activityIndicatorView.removeFromSuperview()
      }
      
      return cell
    case .Info:
      let cell = tableView.dequeueReusableCellWithIdentifier(restInfoCellIdentifier) as! RestaurantInfoTableViewCell
      cell.locationLabel.text = restaurant.distance
      cell.phoneLabel.text = "+7 (999) 999-99-99"
      cell.workTimeLabel.text = restaurant.regime
      cell.addressLabel.text = restaurant.coordName
      return cell
    case .Description:
      let cell = tableView.dequeueReusableCellWithIdentifier(restDescriptionCellIdentifier) as! RestaurantDescriptionTableViewCell
      cell.descrLabel.text = restaurant.restDescription
      return cell
    case .Dishes:
      let cell = tableView.dequeueReusableCellWithIdentifier(restDishesCellIdentifier) as! RestaurantDishesTableViewCell
      cell.dishesArray = restaurant.dishes
      // cell.nameLabel.text = "Dishes (" + "\(restaurant.dishes.count)" + ")"
      return cell
    case .Book:
        let cell = tableView.dequeueReusableCellWithIdentifier(restBookCellIdentifier) as! RestaurantDishesTableViewCell
        return cell
    }
    
  }
  
  // MARK: UITableViewDelegate
  
//  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//    let restaurantInfo = RestaurantInfo(rawValue: indexPath.row)!
//    switch restaurantInfo {
//    case .Images:
//      return 180.0
//    case .Info:
//      return 50.0
//    case .Description:
//      return 46.0
//    case .Dishes:
//      return 44.0
//    case .Book:
//      return 44.0
//    }
//  }
  
  func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    let restaurantInfo = RestaurantInfo(rawValue: indexPath.row)!
    switch restaurantInfo {
    case .Images:
      return 180.0
    case .Info:
      return 50.0
    case .Description:
      return 46.0
    case .Dishes:
      return 44.0
    case .Book:
      return 44.0
    }
  }
  
  //  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
  //      return 90
  //  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
  
  // MARK: Helper

  
}