//
//  Theme.swift
//
//  Created by Alex Shoshiashvili on 14.02.16.
//  Copyright © 2016 alexsho. All rights reserved.
//

import UIKit

class Theme: NSObject {
  
  class func defaultBorderWidth() -> CGFloat {
    return 1.0
  }
  
  class colors {
    
    class func defaultClearColor() -> UIColor {
      return UIColor.clearColor()
    }
    
    class func defaultWhiteColor() -> UIColor {
      return UIColor.whiteColor()
    }
    
    class func defaultBlackColor() -> UIColor {
      return UIColor.blackColor()
    }
    
    class func defaultDarkGrayColor() -> UIColor {
      return UIColor.darkGrayColor()
    }
    
    class func defaultLightTextColor() -> UIColor {
      return UIColor(hexString: "#999999")
    }
    
    class func defaultDarkTextColor() -> UIColor {
      return UIColor(hexString: "#6d6d72")
    }
    
    class func defaultLightGrayColor() -> UIColor {
      return UIColor(hexString: "#bfbfbf")
    }
    
    class func defaultDisabledButtonColor() -> UIColor {
      return UIColor(hexString: "#b6b6b8")
    }
    
    class func defaultPlaceholderColor() -> UIColor {
      return UIColor(hexString: "#c4c4c9")
    }
    
    class func defaultUnreadMessageColor() -> UIColor {
      return UIColor(hexString: "#f9f9f9")
    }
    
    class func defaultBlueColor() -> UIColor {
      return UIColor(hexString: "#1d8ce1")
    }
    
    class func defaultOrnageColor() -> UIColor {
      return UIColor(hexString: "#f9b912")
    }
    
    class func defaultHighlightedCell() -> UIColor {
      return UIColor(hexString: "#fafafa")
    }
    
    class func defaultAuthBackgroundColor() -> UIColor {
      return UIColor(hexString: "#363636")
    }
    
    // MARK: Style
    
    class func defaultNavigationBarColor() -> UIColor {
      return UIColor(hexString: "#2d2f43")
    }
    
    class func defaultStatusBarColor() -> UIColor {
      return defaultNavigationBarColor()
    }
    
    class func defaultColor() -> UIColor {
      return UIColor(hexString: "#1faaec")
    }
    
    class func defaultAddTaskControllerColor() -> UIColor {
      return UIColor(hexString: "#1faaec")
    }
    
    class func defaultTableViewBackroundColor() -> UIColor {
      return UIColor(hexString: "#fafafa")
    }
    
    // MARK: RightInfoView
    
    class func rightViewInWorkBackgroundColor() -> UIColor {
      return UIColor(hexString: "#009ce6")
    }
    
    class func rightViewInSearchingBackgroundColor() -> UIColor {
      return UIColor(hexString: "#2d2f43")
    }
    
    class func rightViewWaitingReviewBackgroundColor() -> UIColor {
      return UIColor(hexString: "#00985d")
    }
    
    class func rightViewArbitrationBackgroundColor() -> UIColor {
      return UIColor(hexString: "#d31453")
    }
    
    class func rightViewDoneBackgroundColor() -> UIColor {
      return UIColor(hexString: "#b5b3c4")
    }
    
    // MARK: StatusContainerView
    
    class func statusContainerViewInWorkBackgroundColor() -> UIColor {
      return rightViewInWorkBackgroundColor()
    }
    
    class func statusContainerViewInSearchingBackgroundColor() -> UIColor {
      return UIColor(hexString: "#232537")
    }
    
    class func statusContainerViewArbitrationBackgroundColor() -> UIColor {
      return UIColor(hexString: "#ff5e3a")
    }
    
    class func statusContainerViewWaitingReviewBackgroundColor() -> UIColor {
      return UIColor(hexString: "#00985d")
    }
    
    class func statusContainerViewDoneBackgroundColor() -> UIColor {
      return rightViewDoneBackgroundColor()
    }
    
    // MARK: BottomContainerView
    
    class func bottomContainerViewButtonInSearchColor() -> UIColor {
      return UIColor(hexString: "#1faaec")
    }
    
    class func bottomContainerViewButtonWaitingReviewColor() -> UIColor {
      return statusContainerViewWaitingReviewBackgroundColor()
    }
    
    // MARK: Button Text Color
    
    class func highlightedWordInButtonColor() -> UIColor {
      return UIColor(hexString: "#2d2f43")
    }
    
    class func defaultButtonColor() -> UIColor {
      return UIColor(hexString: "#1faaec")
    }
    
  }
  
  class buttons {
    
    class func defaultButtonCornerRadius() -> CGFloat {
      return 10.0
    }
    
  }
  
}
