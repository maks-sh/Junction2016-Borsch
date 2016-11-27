//
//  ImageServices.swift
//  Molnia
//
//  Created by Alex Shoshiashvili on 26.08.16.
//  Copyright © 2016 Alex Shoshiashvili. All rights reserved.
//

import UIKit
import Foundation

class ImageServices {

  class func uploadImagesToCloudinary(imagesArray: [UIImage], uiHandler: ((error: NSError?, photos: [Photo]?) -> ())?) {
    
    let dispatchGroup = GCDGroup()
    
    var photosArray = [Photo]()
    for image in imagesArray {
      dispatchGroup.enter()
      uploadImageToCloudinary(image, uiHandler: { (error, photo) in
        dispatchGroup.leave()
        if let newError = error {
          uiHandler?(error: newError, photos: photosArray)
        }
        if let newPhoto = photo {
          photosArray.append(newPhoto)
        }
      })
    }
    
    dispatchGroup.notify(.Main) {
        uiHandler?(error: nil, photos: photosArray)
    }
  }
  
  class func uploadImageToCloudinary(image: UIImage, uiHandler: ((error: NSError?, photo: Photo?) -> ())?) {
    let imageData = UIImageJPEGRepresentation(image, 0.1)
    uploadImageDataToCloudinary(imageData!) { (error, photo) in
      uiHandler?(error: error, photo: photo)
    }
  }
  
  class func uploadImageDataToCloudinary(imageData: NSData, uiHandler: ((error: NSError?, photo: Photo?) -> ())?) {
//    let cloudinary = CLCloudinary(url: EngineRelatedConstants.cloudinaryURL)
//    
//    let transformation = CLTransformation()
//    transformation.crop = "thumb"
//    
//    let uploader = CLUploader(cloudinary, delegate: nil)
//    uploader.upload(imageData, options: ["transformation":transformation], withCompletion: { (successResult, errorResult, code, context) in
//      
//      if (successResult != nil) {
//        let photo = Photo(successResult)
//        print("Block upload success. Public ID = \(photo.publicId), Full result = \(successResult)")
//        uiHandler?(error: nil, photo: photo)
//      } else {
//        print("Block upload error: \(errorResult) code: \(code)")
//        let error = NSError(message: errorResult)
//        uiHandler?(error: error, photo: nil)
//      }
//      
//    }) { (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite, context) in
//      print("Block upload progress: \(totalBytesWritten)/\(totalBytesExpectedToWrite) (+\(bytesWritten))", totalBytesWritten, totalBytesExpectedToWrite, bytesWritten);
//    }
  }
  
}
