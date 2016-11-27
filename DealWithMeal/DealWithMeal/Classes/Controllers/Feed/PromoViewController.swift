//
//  PromoViewController.swift
//  DealWithMeal
//
//  Created by Alex Shoshiashvili on 26.11.16.
//  Copyright © 2016 Alex Shoshiashvili. All rights reserved.
//

import UIKit

class PromoViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var promosArray = [Task]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    promosArray.append(Task())
    promosArray.append(Task())
    promosArray.append(Task())
    promosArray.append(Task())
    promosArray.append(Task())
    
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}

extension PromoViewController : UITableViewDelegate, UITableViewDataSource {
  
  // MARK: - UITableViewDataSource
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return promosArray.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let saleCellIdentifier = "saleCellIdentifier"
    
    let promo = promosArray[indexPath.row]
    
    let cell = tableView.dequeueReusableCellWithIdentifier(saleCellIdentifier) as! PromoTableViewCell
    cell.promoImageView.image = UIImage(named: "backIcon")
    cell.restName.text = "Tili-tili"
    cell.fullDescription.text = "Happy sale for Happy New Year"
    cell.shortDescription.text = "10% sale"
    
    return cell
    
  }
  
  // MARK: UITableViewDelegate
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return  100
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
  
  // MARK: Helper
  
  
}