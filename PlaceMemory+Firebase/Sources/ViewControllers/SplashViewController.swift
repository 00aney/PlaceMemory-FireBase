//
//  SplashViewController.swift
//  PlaceMemory+Firebase
//
//  Created by aney on 2017. 5. 5..
//  Copyright © 2017년 Taedong Kim. All rights reserved.
//

import UIKit

import Firebase

class SplashViewController: UIViewController {

  // MARK: Properties
  
  fileprivate let activateIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
  
  
  // MARK: View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    self.activateIndicatorView.startAnimating()
    self.view.addSubview(self.activateIndicatorView)
    self.activateIndicatorView.anchor(top: self.view.topAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    if FIRAuth.auth()?.currentUser == nil {
      // Login View Controller
      AppDelegate.instance?.presentLoginScreen()
    } else {
      // Profile View Controller
      AppDelegate.instance?.presentMainScreen()
    }
  }
  
}
