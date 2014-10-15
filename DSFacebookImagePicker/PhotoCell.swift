//
//  PhotoCell.swift
//  DSFacebookImagePicker
//
//  Created by Home on 2014-10-14.
//  Copyright (c) 2014 Sanche. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
  
  @IBOutlet weak var imageView: UIImageView!
  
  override func prepareForReuse() {
    imageView?.image = UIImage(named:"dirtblock")
  }
  
  func setUpWithPhoto(photo:Photo){
    photo.loadThumbnail()
    setImage(photo)
  }
  
  func setImage(photo:Photo){
    if let foundPhoto = photo.thumbnailData{
      imageView?.image = foundPhoto
    } else if !photo.imageLoadFailed {
      let delay = 0.1 * Double(NSEC_PER_SEC)
      let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
      
      dispatch_after(time, dispatch_get_main_queue(), { () in
        self.setImage(photo)
      })
    }
  }
}
