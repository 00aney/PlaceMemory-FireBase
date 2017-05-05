//
//  User.swift
//  PlaceMemory+Firebase
//
//  Created by aney on 2017. 5. 5..
//  Copyright © 2017년 Taedong Kim. All rights reserved.
//

struct User {
  
  let username: String
  let profileImageURL: String
  
  init(dictionary: [String: Any]) {
    self.username = dictionary["username"] as? String ?? ""
    self.profileImageURL = dictionary["profileImageURL"] as? String ?? ""
  }
  
}
