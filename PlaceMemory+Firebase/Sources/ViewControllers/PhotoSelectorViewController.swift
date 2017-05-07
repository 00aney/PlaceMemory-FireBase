//
//  PhotoSelectorViewController.swift
//  PlaceMemory+Firebase
//
//  Created by aney on 2017. 5. 6..
//  Copyright © 2017년 Taedong Kim. All rights reserved.
//

import Photos
import UIKit

class PhotoSelectorViewController: UICollectionViewController {
  
  // MARK: Properties
  var images = [UIImage]()
  var assets = [PHAsset]()
  var selectedImage: UIImage?
  
  
  // MARK: View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.collectionView?.backgroundColor = .white
    
    self.setupNavigationButtons()
    
    self.collectionView?.register(PhotoSelectorHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerId")
    self.collectionView?.register(PhotoSelectorCell.self, forCellWithReuseIdentifier: "cellId")
    
    self.fetchPhotos()
  }
  
  
  // MARK: CollectionView
  
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as! PhotoSelectorHeader
    
    // TODO: Configuring Header
    if let selectedImage = self.selectedImage {
      if let index = self.images.index(of: selectedImage) {
        let selectedAsset = self.assets[index]
        header.configure(photoImage: self.selectedImage, asset: selectedAsset)
      }
    }
    
    return header
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.images.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PhotoSelectorCell
    cell.configure(photoImage: self.images[indexPath.item])
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    self.selectedImage = self.images[indexPath.item]
    collectionView.reloadData()
    
    let indexPath = IndexPath(item: 0, section: 0)
    collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
  }
  
  
  // MARK: - Other Functions
  
  fileprivate func setupNavigationButtons() {
    self.navigationController?.navigationBar.tintColor = .black
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonDidTap))
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextButtonDidTap))
  }
  
  fileprivate func assetsFetchOptions() -> PHFetchOptions {
    let fetchOptions = PHFetchOptions()
    fetchOptions.fetchLimit = 32  // fetch 개수
    let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
    fetchOptions.sortDescriptors = [sortDescriptor]
    return fetchOptions
  }
  
  fileprivate func fetchPhotos() {
    /*
     <PHAsset: 0x7fcc78e1f100> 82C35D90-68AB-4CB2-874E-73F13EF5DED6/L0/001 mediaType=1/0, sourceType=1, (686x420), creationDate=2017-04-09 15:53:54 +0000, location=0, hidden=0, favorite=0
     */
    let allPhotos = PHAsset.fetchAssets(with: .image, options: self.assetsFetchOptions())
    
    //background thread
    DispatchQueue.global(qos: .background).async {
      allPhotos.enumerateObjects({ [weak self] asset, index, stop in
//        print(index)
        guard let `self` = self else { return }
        
        // download image & set image
        let imageManager = PHImageManager.default()
        let targetSize = CGSize(width: 200, height: 200)  // 이미지 사이즈
        let options = PHImageRequestOptions()
        options.isSynchronous = true  // 동기안하면, 두번 fetch될 수도 있음
        imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: options, resultHandler: { [weak self] image, info in
          guard let `self` = self else { return }
          
          if let image = image {
            self.images.append(image)
            self.assets.append(asset)
            
            if self.selectedImage == nil {  // 첫 이미지로 지정
              self.selectedImage = image
            }
          }
          
          if index == allPhotos.count - 1 { // fetch 개수 마지막일 때, 콜렉션 뷰 리로드
            DispatchQueue.main.async {
              self.collectionView?.reloadData()
            }
            
          }
          
          // TODO: paging photo list
          
        })
      })
    }
  }
  
  
  // MARK: Actions
  
  fileprivate dynamic func cancelButtonDidTap() {
    self.dismiss(animated: true, completion: nil)
  }
  
  fileprivate dynamic func nextButtonDidTap() {
    guard let image = self.selectedImage else { return }
    let sharePhotoViewController = SharePhotoViewController(image: image)
    self.navigationController?.pushViewController(sharePhotoViewController, animated: true)
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
