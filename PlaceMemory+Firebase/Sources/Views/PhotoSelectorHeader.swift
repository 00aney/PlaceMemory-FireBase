//
//  PhotoSelectorHeader.swift
//  PlaceMemory+Firebase
//
//  Created by aney on 2017. 5. 7..
//  Copyright © 2017년 Taedong Kim. All rights reserved.
//

import Photos
import UIKit

class PhotoSelectorHeader: UICollectionViewCell {
  
  // MARK: UI
  
  let photoImageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    iv.backgroundColor = .lightGray
    return iv
  }()
  
  
  // MARK: Initializing
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.addSubview(self.photoImageView)
    self.photoImageView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: Configuring
  
  func configure(photoImage: UIImage?, asset: PHAsset?) {
    guard let image = photoImage else { return }
    self.photoImageView.image = image
    
    guard let asset = asset else { return }
    let imageManager = PHImageManager.default()
    let targetSize = CGSize(width: 800, height: 800)
    
    imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: nil) { [weak self] image, info in
      guard let `self` = self else { return }
      self.photoImageView.image = image
    }
  }
  
}
