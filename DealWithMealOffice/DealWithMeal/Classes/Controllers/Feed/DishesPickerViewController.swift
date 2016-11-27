//
//  DishesPickerViewController.swift
//  DealWithMeal
//
//  Created by Alex Shoshiashvili on 27.11.16.
//  Copyright © 2016 Alex Shoshiashvili. All rights reserved.
//

import UIKit

protocol DishesPickerViewControllerDelegate {
  func selectedDishes(dishes: [Dish])
}

class DishesPickerViewController: MainViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  @IBOutlet weak var saveBarButton: UIBarButtonItem!
  
  var dishesArray = [Dish]()
  var selectedDishesArray = [Dish]()
  var delegate: DishesPickerViewControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    loadRestaurant()
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.estimatedRowHeight = 90.0
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.allowsMultipleSelection = true
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func loadRestaurant() {
    startActivityViewAnimating()
    
    RestServices.restaurantById(restId: "5") { (error, restaurantById) in
      self.stopActivityViewAnimating()
      if error != nil {
        print("blyat")
      } else {
        self.dishesArray = restaurantById!.dishes
        self.tableView.reloadData()
      }
    }
    
  }
  
  @IBAction func handleSaveAction(sender: AnyObject) {
    delegate?.selectedDishes(selectedDishesArray)
    popViewController()
  }
  
}

extension DishesPickerViewController: UITableViewDelegate, UITableViewDataSource {
  
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
    
    cell.selectionStyle = .None
    
    cell.accessoryType = cell.selected ? .Checkmark : .None
    
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
    tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .Checkmark
    selectedDishesArray.append(dishesArray[indexPath.row])
  }
  
  func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .None
    selectedDishesArray.removeObject(dishesArray[indexPath.row])
  }
  
}
