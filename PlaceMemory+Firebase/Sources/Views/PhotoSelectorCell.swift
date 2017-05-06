//
//  PhotoSelectorCell.swift
//  PlaceMemory+Firebase
//
//  Created by aney on 2017. 5. 6..
//  Copyright © 2017년 Taedong Kim. All rights reserved.
//

import UIKit

class PhotoSelectorCell: UICollectionViewCell {
  
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
  
  func configure(photoImage: UIImage?) {
    guard let image = photoImage else { return }
    self.photoImageView.image = image
  }
  
}
