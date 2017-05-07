//
//  SharePhotoViewController.swift
//  PlaceMemory+Firebase
//
//  Created by aney on 2017. 5. 7..
//  Copyright © 2017년 Taedong Kim. All rights reserved.
//

import UIKit

import Firebase

class SharePhotoViewController: UIViewController {
  
  // MARK: Constants
  
  struct Color {
    static let background = UIColor.rgb(red: 240, green: 240, blue: 240)
  }
  
  struct Font {
    static let textView = UIFont.systemFont(ofSize: 14)
  }
  
  
  // MARK: Properties
  
  var selectedImage: UIImage?
  
  // TODO: 위치 저장
  
  
  // MARK: UI
  
  let imageView: UIImageView = {
    let iv = UIImageView()
    iv.backgroundColor = .white
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    return iv
  }()
  
  let titleTextView: UITextView = {
    let tv = UITextView()
    tv.font = Font.textView
    return tv
  }()
  
  let contentTextView: UITextView = {
    let tv = UITextView()
    tv.font = Font.textView
    return tv
  }()
  
  
  // MARK: View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = Color.background
    
    self.setupNavigationButtons()
    self.setupImageAndTextView()
  }
  
  
  // MARK: Initializing
  
  init(image: UIImage) {
    super.init(nibName: nil, bundle: nil)
    self.selectedImage = image
    self.imageView.image = self.selectedImage
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Other Functions
  
  fileprivate func setupNavigationButtons() {
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Upload", style: .plain, target: self, action: #selector(uploadButtonDidTap))
  }
  
  fileprivate func setupImageAndTextView() {
    let containerView = UIView()
    containerView.backgroundColor = Color.background
    
    self.view.addSubview(containerView)
    containerView.anchor(top: self.topLayoutGuide.bottomAnchor, left: self.view.leftAnchor, bottom: nil, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 150)
    
    containerView.addSubview(self.imageView)
    self.imageView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 150, height: 150)
    
    containerView.addSubview(self.titleTextView)
    self.titleTextView.anchor(top: containerView.topAnchor, left: self.imageView.rightAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: 0, height: 30)
    
    containerView.addSubview(self.contentTextView)
    self.contentTextView.anchor(top: self.titleTextView.bottomAnchor, left: self.imageView.rightAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 4, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
  }
  
  
  // MARK: Actions
  
  fileprivate dynamic func uploadButtonDidTap() {
    guard let title = self.titleTextView.text, title.characters.count > 0 else { return }
    guard let image = self.selectedImage else { return }
    
    guard let uploadData = UIImageJPEGRepresentation(image, 0.5) else { return }
    
    self.navigationItem.rightBarButtonItem?.isEnabled = false
    
    let filename = NSUUID().uuidString
    
    FIRStorage.storage().reference().child("posts").child(filename).put(uploadData, metadata: nil) { metadata, error in
      
      if let error = error {
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        print("Failed to upload post image:", error)
        return
      }
      
      guard let imageURL = metadata?.downloadURL()?.absoluteString else { return }
      
      print("Successfully uploaded post image:", imageURL)
      
      self.saveToDatabaseWithImageURL(imageURL: imageURL)
    }
  }
  
  fileprivate func saveToDatabaseWithImageURL(imageURL: String) {
    guard let postImage = self.selectedImage else { return }
    guard let title = self.titleTextView.text else { return }
    guard let uid = FIRAuth.auth()?.currentUser?.uid else { return }
    let content = self.contentTextView.text ?? ""
    
    let userPostRef = FIRDatabase.database().reference().child("posts").child(uid)
    
    let ref = userPostRef.childByAutoId()
    let values = [
      "imageURL": imageURL,
      "imageWidth": postImage.size.width,
      "imageHeight": postImage.size.height,
      "title": title,
      "content": content,
      "creationDate": Date().timeIntervalSince1970,
    ] as [String : Any]
    
    ref.updateChildValues(values) { error, reference in
      if let error = error {
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        print("Failed to save post to Database:", error)
        return
      }
      
      print("Successfully saved post to Database")
      self.dismiss(animated: true, completion: nil)
    }
  }
  
}
