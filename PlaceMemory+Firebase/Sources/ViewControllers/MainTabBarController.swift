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
    let homeNavagationController = self.templateNavigationController(unselectedImage: #imageLiteral(resourceName: "tab-home-unselected"), selectedImage: #imageLiteral(resourceName: "tab-home-selected"), rootViewController: UserProfileViewController(collectionViewLayout: UICollectionViewFlowLayout()))
    
    let searchNavagationController = self.templateNavigationController(unselectedImage: #imageLiteral(resourceName: "tab-search-unselected"), selectedImage: #imageLiteral(resourceName: "tab-search-selected"), rootViewController: UIViewController())
    
    let plusNavagationController = self.templateNavigationController(unselectedImage: #imageLiteral(resourceName: "tab-upload"), selectedImage: #imageLiteral(resourceName: "tab-upload"), rootViewController: UIViewController())
    
    let likeNavagationController = self.templateNavigationController(unselectedImage: #imageLiteral(resourceName: "icon-like-unselected"), selectedImage: #imageLiteral(resourceName: "icon-like-selected"), rootViewController: UIViewController())
    
    let userProfileNavagationController = self.templateNavigationController(unselectedImage: #imageLiteral(resourceName: "tab-profile-unselected"), selectedImage: #imageLiteral(resourceName: "tab-profile-selected"), rootViewController: UserProfileViewController(collectionViewLayout: UICollectionViewFlowLayout()))
    
    self.tabBar.tintColor = .black
    
    self.viewControllers = [
      homeNavagationController,
      searchNavagationController,
      plusNavagationController,
      likeNavagationController,
      userProfileNavagationController,
    ]
    
    guard let items = self.tabBar.items else { return }
    for item in items {
      item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
    }
  }
  
  fileprivate func templateNavigationController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
    let viewController = rootViewController
    let navigationController = UINavigationController(rootViewController: viewController)
    navigationController.tabBarItem.image = unselectedImage
    navigationController.tabBarItem.selectedImage = selectedImage
    return navigationController
  }
  
}
