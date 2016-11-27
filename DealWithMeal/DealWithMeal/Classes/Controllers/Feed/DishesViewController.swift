//
//  DishesViewController.swift
//  DealWithMeal
//
//  Created by Alex Shoshiashvili on 26.11.16.
//  Copyright © 2016 Alex Shoshiashvili. All rights reserved.
//

import UIKit
import SDWebImage

class DishesViewController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  var dishesArray = [Dish]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    dishesArray.append(Dish())
    dishesArray.append(Dish())
    dishesArray.append(Dish())
    
    collectionView.delegate = self
    collectionView.dataSource = self
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}

extension DishesViewController : UICollectionViewDelegate, UICollectionViewDataSource {
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return dishesArray.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
    let dishCellIdentifier = "dishCellIdentifier"
    
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(dishCellIdentifier, forIndexPath: indexPath) as! DishCollectionViewCell
    
    let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
    activityIndicatorView.center = cell.dishImageView.center
    activityIndicatorView.hidesWhenStopped = true
    cell.dishImageView.addSubview(activityIndicatorView)
    activityIndicatorView.startAnimating()
    
    cell.dishImageView.roundViewWithRadius(10)
    
    cell.dishImageView.sd_setImageWithURL(NSURL(string: "http://gred-tea.com.ua/images/Skolko_kalorij_v_raznih_borshah.jpg")!) { (image, error, cacheType, url) in
      activityIndicatorView.removeFromSuperview()
    }
    
    cell.priceLabel.text = "330".stringWithRubleSymbol()
    cell.nameLabel.text = "Borsch"
    
    return cell
    
  }
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    // delegate?
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    return CGSize(width: 135.0, height: 135.0)
  }
  
}
