//
//  UserProfileHeaderView.swift
//  PlaceMemory+Firebase
//
//  Created by aney on 2017. 5. 5..
//  Copyright © 2017년 Taedong Kim. All rights reserved.
//

import UIKit

class UserProfileHeader: UICollectionViewCell {
  
  // MARK: Properties
  
  var user: User?
  
  // MARK: Initializing
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.backgroundColor = .green
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: Configuring
  
  func configure(user: User?) {
    guard let user = user else { return }
    
    self.user = user
    print(self.user ?? "")
  }
  
}
