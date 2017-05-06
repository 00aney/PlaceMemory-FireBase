//
//  PhotoSelectorViewController.swift
//  PlaceMemory+Firebase
//
//  Created by aney on 2017. 5. 6..
//  Copyright © 2017년 Taedong Kim. All rights reserved.
//

import UIKit

class PhotoSelectorViewController: UICollectionViewController {
  
  // MARK: View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.collectionView?.backgroundColor = .yellow
    
    self.setupNavigationButtons()
    
    self.collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
    self.collectionView?.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerId")
  }
  
  
  // MARK: CollectionView
  
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath)
    header.backgroundColor = .blue
    return header
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 6
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
    cell.backgroundColor = .blue
    return cell
  }
  
  fileprivate func setupNavigationButtons() {
    self.navigationController?.navigationBar.tintColor = .black
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonDidTap))
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextButtonDidTap))
  }
  
  
  // MARK: Actions
  
  fileprivate dynamic func cancelButtonDidTap() {
    self.dismiss(animated: true, completion: nil)
  }
  
  fileprivate dynamic func nextButtonDidTap() {
    print("nextButtonDidTap")
  }
}


// MARK: - UICollectionViewDelegateFlowLayout

extension PhotoSelectorViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    let width = self.view.frame.width
    return CGSize(width: width, height: width)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = (self.view.frame.width - 3) / 4
    return CGSize(width: width, height: width)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
  }
  
}
