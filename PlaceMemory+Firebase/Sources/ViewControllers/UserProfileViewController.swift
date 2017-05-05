//
//  UserProfileViewController.swift
//  PlaceMemory+Firebase
//
//  Created by aney on 2017. 5. 5..
//  Copyright © 2017년 Taedong Kim. All rights reserved.
//

import UIKit

import Firebase

class UserProfileViewController: UICollectionViewController {
  
  // MARK: Properties
  
  var user: User?
  
  
  // MARK: View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.collectionView?.backgroundColor = .white
    
    self.collectionView?.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerViewId")
    self.collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
    
    self.fetchUser()
    
    self.setupLogOutButton()
  }
  
  fileprivate func setupLogOutButton() {
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icon-gear").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(logOutButtonDidTap))
  }
  
  fileprivate dynamic func logOutButtonDidTap() {
    let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    
    alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
      
      do {
        try FIRAuth.auth()?.signOut()
        
        AppDelegate.instance?.presentLoginScreen()
      } catch let error {
        print("Failed to sign out:", error)
      }
      
    }))
    
    alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
    self.present(alertController, animated: true, completion: nil)
  }
  
  // MARK: CollectionView
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 7
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
    
    cell.backgroundColor = .blue
    
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerViewId", for: indexPath) as! UserProfileHeader
    
    header.configure(user: self.user)

    return header
  }
  
  
  // MARK: Firebase
  
  fileprivate func fetchUser() {
    guard let uid = FIRAuth.auth()?.currentUser?.uid else { return }
    FIRDatabase.database().reference().child("users").child(uid)
      .observeSingleEvent(
        of: .value,
        with: { [weak self] snapshot in
          guard let `self` = self else { return }
          
          guard let dictionary = snapshot.value as? [String: Any] else { return }
          self.user = User(dictionary: dictionary)
          self.navigationItem.title = self.user?.username
          
          self.collectionView?.reloadData()
      }) { error in
        print("Failed to fetch user:", error)
      }
  }
  
}


// MARK: - UICollectionViewDelegateFlowLayout

extension UserProfileViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: self.view.frame.width, height: 200)
  }
  
}
