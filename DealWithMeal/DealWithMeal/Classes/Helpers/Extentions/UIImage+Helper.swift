//
//  UIImage+Helper.swift
//
//  Created by Alex Shoshiashvili on 14.02.16.
//  Copyright © 2016 alexsho. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
  
  class func imageFromLayer(layer: CALayer) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(layer.frame.size, layer.opaque, 0)
    
    layer.renderInContext(UIGraphicsGetCurrentContext()!)
    let outputImage = UIGraphicsGetImageFromCurrentImageContext()
    
    UIGraphicsEndImageContext()
    
    return outputImage
  }
  
  class func imageWithImage(image: UIImage, withOpaque opaque: Bool, convertToSize size: CGSize) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(size, opaque, 0.0)
    
    image.drawInRect(CGRectMake(0, 0, size.width, size.height))
    let resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resizedImage;
  }
  
  class func imageWithImage(image: UIImage, withOpaque opaque: Bool, withInterpolationQuality quality: CGInterpolationQuality, convertToSize size: CGSize) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(size, opaque, 0.0)
    
    image.drawInRect(CGRectMake(0, 0, size.width, size.height))
    CGContextSetInterpolationQuality(UIGraphicsGetCurrentContext() , quality);
    let resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resizedImage
  }
  
  class func convert(imageNamed: String, toSize: CGSize) -> UIImage {
    return UIImage.imageWithImage(UIImage(named: imageNamed)!, withOpaque: false, convertToSize: toSize)
  }
  
  class func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
    let rect = CGRectMake(0, 0, size.width, size.height)
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    color.setFill()
    UIRectFill(rect)
    let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
  }
  
  class func imageFromView(view: UIView) -> UIImage {
    let size = CGSizeMake(view.frame.size.width, view.frame.size.height)
    UIGraphicsBeginImageContext(size)
    view.drawViewHierarchyInRect(CGRect(origin: CGPointZero, size: CGSizeMake(view.frame.size.width, view.frame.size.height)), afterScreenUpdates: true)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image
  }
  
  class func imageFromView(view: UIView, inRect rect: CGRect) -> UIImage {
    UIGraphicsBeginImageContext(rect.size);
    view.drawViewHierarchyInRect(rect, afterScreenUpdates: true)
    let image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
  }
  
  public func imageRotatedByDegrees(degrees: CGFloat, flip: Bool) -> UIImage {
    
    let degreesToRadians: (CGFloat) -> CGFloat = {
      return $0 / 180.0 * CGFloat(M_PI)
    }
    
    // calculate the size of the rotated view's containing box for our drawing space
    let rotatedViewBox = UIView(frame: CGRect(origin: CGPointZero, size: size))
    let t = CGAffineTransformMakeRotation(degreesToRadians(degrees));
    rotatedViewBox.transform = t
    let rotatedSize = rotatedViewBox.frame.size
    
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize)
    let bitmap = UIGraphicsGetCurrentContext()
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width / 2.0, rotatedSize.height / 2.0);
    
    //   // Rotate the image context
    CGContextRotateCTM(bitmap, degreesToRadians(degrees));
    
    // Now, draw the rotated/scaled image into the context
    var yFlip: CGFloat
    
    if(flip){
      yFlip = CGFloat(-1.0)
    } else {
      yFlip = CGFloat(1.0)
    }
    
    CGContextScaleCTM(bitmap, yFlip, -1.0)
    CGContextDrawImage(bitmap, CGRectMake(-size.width / 2, -size.height / 2, size.width, size.height), CGImage)
    
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage
  }
  
  class func imageFixOrientation(img:UIImage) -> UIImage {
    
    // No-op if the orientation is already correct
    if (img.imageOrientation == UIImageOrientation.Up) {
      return img;
    }
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    var transform:CGAffineTransform = CGAffineTransformIdentity
    
    if (img.imageOrientation == UIImageOrientation.Down
      || img.imageOrientation == UIImageOrientation.DownMirrored) {
        
        transform = CGAffineTransformTranslate(transform, img.size.width, img.size.height)
        transform = CGAffineTransformRotate(transform, CGFloat(M_PI))
    }
    
    if (img.imageOrientation == UIImageOrientation.Left
      || img.imageOrientation == UIImageOrientation.LeftMirrored) {
        
        transform = CGAffineTransformTranslate(transform, img.size.width, 0)
        transform = CGAffineTransformRotate(transform, CGFloat(M_PI_2))
    }
    
    if (img.imageOrientation == UIImageOrientation.Right
      || img.imageOrientation == UIImageOrientation.RightMirrored) {
        
        transform = CGAffineTransformTranslate(transform, 0, img.size.height);
        transform = CGAffineTransformRotate(transform,  CGFloat(-M_PI_2));
    }
    
    if (img.imageOrientation == UIImageOrientation.UpMirrored
      || img.imageOrientation == UIImageOrientation.DownMirrored) {
        
        transform = CGAffineTransformTranslate(transform, img.size.width, 0)
        transform = CGAffineTransformScale(transform, -1, 1)
    }
    
    if (img.imageOrientation == UIImageOrientation.LeftMirrored
      || img.imageOrientation == UIImageOrientation.RightMirrored) {
        
        transform = CGAffineTransformTranslate(transform, img.size.height, 0);
        transform = CGAffineTransformScale(transform, -1, 1);
    }
    
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    let ctx:CGContextRef = CGBitmapContextCreate(nil, Int(img.size.width), Int(img.size.height), CGImageGetBitsPerComponent(img.CGImage), 0, CGImageGetColorSpace(img.CGImage), CGImageGetBitmapInfo(img.CGImage).rawValue)!
    CGContextConcatCTM(ctx, transform)
    
    
    if (img.imageOrientation == UIImageOrientation.Left
      || img.imageOrientation == UIImageOrientation.LeftMirrored
      || img.imageOrientation == UIImageOrientation.Right
      || img.imageOrientation == UIImageOrientation.RightMirrored
      ) {
        
        CGContextDrawImage(ctx, CGRectMake(0,0,img.size.height,img.size.width), img.CGImage)
    } else {
      CGContextDrawImage(ctx, CGRectMake(0,0,img.size.width,img.size.height), img.CGImage)
    }
    
    
    // And now we just create a new UIImage from the drawing context
    let cgimg:CGImageRef = CGBitmapContextCreateImage(ctx)!
    let imgEnd:UIImage = UIImage(CGImage: cgimg)
    
    return imgEnd
  }
  
  public func resize(size:CGSize, completionHandler:(resizedImage:UIImage, data:NSData)->()) {
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), { () -> Void in
      let newSize:CGSize = size
      let rect = CGRectMake(0, 0, newSize.width, newSize.height)
      UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
      self.drawInRect(rect)
      let newImage = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      let imageData = UIImageJPEGRepresentation(newImage, 0.5)
      dispatch_async(dispatch_get_main_queue(), { () -> Void in
        completionHandler(resizedImage: newImage, data:imageData!)
      })
    })
  }
  
  func resizeToWidth(width:CGFloat)-> UIImage {
    let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
    imageView.contentMode = UIViewContentMode.ScaleAspectFit
    imageView.image = self
    UIGraphicsBeginImageContext(imageView.bounds.size)
    imageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
    let result = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return result
  }
  
  func tintWithColor(color: UIColor) -> UIImage {
    
    UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.mainScreen().scale)
    let context = UIGraphicsGetCurrentContext()
    
    // flip the image
    CGContextScaleCTM(context, 1.0, -1.0)
    CGContextTranslateCTM(context, 0.0, -self.size.height)
    
    // multiply blend mode
    CGContextSetBlendMode(context, .Multiply)
    
    let rect = CGRectMake(0, 0, self.size.width, self.size.height)
    CGContextClipToMask(context, rect, self.CGImage)
    color.setFill()
    CGContextFillRect(context, rect)
    
    // create uiimage
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage
    
  }
  
}