//
//  ErrorViewViewController.swift
//  DealWithMeal
//
//  Created by Alex Shoshiashvili on 26.11.16.
//  Copyright © 2016 Alex Shoshiashvili. All rights reserved.
//

import UIKit

class ErrorViewViewController: UIViewController {

  @IBOutlet weak var webView: UIWebView!
  @IBOutlet weak var refreshButton: UINavigationItem!
  
  var titleString = "FAQ"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    webView = UIWebView()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func handleRefreshAction(sender: AnyObject) {
    
    
    
  }

}
