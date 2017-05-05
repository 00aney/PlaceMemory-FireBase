//
//  MainTabBarViewController.swift
//  PlaceMemory+Firebase
//
//  Created by aney on 2017. 5. 5..
//  Copyright © 2017년 Taedong Kim. All rights reserved.
//

import UIKit

import Firebase

class MainTabBarController: UITabBarController {
  
  
  // MARK: View Life Cycle
  
  override func viewDidLoad() {
    let userProfileViewController = UserProfileViewController(collectionViewLayout: UICollectionViewFlowLayout())
    let navigationController = UINavigationController(rootViewController: userProfileViewController)
    
    navigationController.tabBarItem.image = #imageLiteral(resourceName: "tabfeed-profile-unselected")
    navigationController.tabBarItem.selectedImage = #imageLiteral(resourceName: "tabfeed-profile-selected")
    self.tabBar.tintColor = .black
    
    self.viewControllers = [navigationController, UIViewController()]
  }
  
}
