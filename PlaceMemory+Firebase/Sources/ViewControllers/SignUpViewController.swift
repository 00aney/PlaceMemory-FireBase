//
//  ViewController.swift
//  PlaceMemory+Firebase
//
//  Created by aney on 2017. 5. 1..
//  Copyright © 2017년 Taedong Kim. All rights reserved.
//

import UIKit

import Firebase

class SignUpViewController: UIViewController {
  
  // MARK: Constants
  
  struct Metric {
    static let titleLabelTop = 40.f
    
    static let plusPhotoButtonTop = 40.f
    static let plusPhotoButtonWidth = 140.f
    static let plusPhotoButtonHeight = 140.f
    
    static let stackViewLeft = 40.f
    static let stackViewRight = -40.f
    static let stackViewHeight = 200.f
  }
  
  struct Font {
    static let titleLabelField = UIFont.systemFont(ofSize: 30)
    static let textField = UIFont.systemFont(ofSize: 14)
    static let signUpButton = UIFont.boldSystemFont(ofSize: 14)
  }
  
  struct Color {
    static let signUpButtonBackground = UIColor.rgb(red: 149, green: 204, blue: 244)
    static let signUpButtonEnabled = UIColor.rgb(red: 17, green: 154, blue: 237)
    static let signUpButtonUnabled = UIColor.rgb(red: 149, green: 204, blue: 244)
    
  }
  
  
  // MARK: UI
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "장소 기억"
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = Font.titleLabelField
    return label
  }()
  
  let plusPhotoButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(#imageLiteral(resourceName: "plus-photo").withRenderingMode(.alwaysOriginal), for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(plusPhotoButtonDidTap), for: .touchUpInside)
    return button
  }()
  
  let emailTextField: UITextField = {
    let tf = UITextField()
    tf.placeholder = "Email"
    tf.translatesAutoresizingMaskIntoConstraints = false
    tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
    tf.font = Font.textField
    tf.borderStyle = .roundedRect
    tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
    return tf
  }()
  
  let usernameTextField: UITextField = {
    let tf = UITextField()
    tf.placeholder = "Username"
    tf.translatesAutoresizingMaskIntoConstraints = false
    tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
    tf.font = Font.textField
    tf.borderStyle = .roundedRect
    tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
    return tf
  }()
  
  let passwordTextField: UITextField = {
    let tf = UITextField()
    tf.placeholder = "Password"
    tf.isSecureTextEntry = true
    tf.translatesAutoresizingMaskIntoConstraints = false
    tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
    tf.font = Font.textField
    tf.borderStyle = .roundedRect
    tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
    return tf
  }()
  
  let signUpButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Sign Up", for: .normal)
    button.backgroundColor = Color.signUpButtonBackground
    button.layer.cornerRadius = 5
    button.titleLabel?.font = Font.signUpButton
    button.setTitleColor(.white, for: .normal)
    button.addTarget(self, action: #selector(signUpButtonDidTap), for: .touchUpInside)
    button.isEnabled = false
    return button
  }()
  
  let alreadyHaveAccountButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("계정이 있으신가요?  로그인", for: .normal)
    button.addTarget(self, action: #selector(alreadyHaveAccountButtonDidTap), for: .touchUpInside)
    return button
  }()
  
  
  // MARK: View Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .white
    
    self.view.addSubview(self.titleLabel)
    
    NSLayoutConstraint.activate([
      self.titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: Metric.titleLabelTop),
      self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
    ])
    
    self.view.addSubview(self.plusPhotoButton)
    
    NSLayoutConstraint.activate([
      self.plusPhotoButton.topAnchor.constraint(equalTo: self.titleLabel.topAnchor, constant: Metric.plusPhotoButtonTop),
      self.plusPhotoButton.widthAnchor.constraint(equalToConstant: Metric.plusPhotoButtonWidth),
      self.plusPhotoButton.heightAnchor.constraint(equalToConstant: Metric.plusPhotoButtonHeight),
      self.plusPhotoButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
    ])
    
    self.setupInputFields()
    
    self.view.addSubview(self.alreadyHaveAccountButton)
    self.alreadyHaveAccountButton.anchor(top: nil, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 30)
  }
  
  
  // MARK: Layout
  
  fileprivate func setupInputFields() {
    let stackView = UIStackView(
      arrangedSubviews: [
        self.emailTextField,
        self.usernameTextField,
        self.passwordTextField,
        self.signUpButton,
      ]
    )
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.distribution = .fillEqually
    stackView.axis = .vertical
    stackView.spacing = 10
    
    self.view.addSubview(stackView)
    
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: self.plusPhotoButton.bottomAnchor, constant: 20),
      stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: Metric.stackViewLeft),
      stackView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: Metric.stackViewRight),
      stackView.heightAnchor.constraint(equalToConstant: Metric.stackViewHeight)
    ])
  }
  
  
  // MARK: Actions
  
  func handleTextInputChange() {
    let isFormValid = self.emailTextField.text?.characters.count ?? 0 > 0 &&
      self.emailTextField.text?.contains("@") ?? false &&
      self.usernameTextField.text?.characters.count ?? 0 > 0 &&
      self.passwordTextField.text?.characters.count ?? 0 > 0
    
    if isFormValid {
      self.signUpButton.isEnabled = true
      self.signUpButton.backgroundColor = Color.signUpButtonEnabled
    } else {
      self.signUpButton.isEnabled = false
      self.signUpButton.backgroundColor = Color.signUpButtonUnabled
    }
  }
  
  func signUpButtonDidTap() {
    //가입이 되면, 프로필 사진이 있으면, 프로필 사진 업로드, 
    // 없으면, 가입만 진행
    
    guard let email = self.emailTextField.text, email.characters.count > 0 else { return }
    guard let username = self.usernameTextField.text, username.characters.count > 0 else { return }
    guard let password = self.passwordTextField.text, password.characters.count > 0 else { return }
    
    FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { [weak self] user, error in
      guard let `self` = self else { return }
      
      if let error = error {
        print("Failed to create user:", error)
        return
      }
      
      print("Successfully created user:", user?.uid ?? "")
      
      guard let profileImage = self.plusPhotoButton.imageView?.image else { return }
      guard let uploadData = UIImageJPEGRepresentation(profileImage, 0.3) else { return }
      
      let filename = NSUUID().uuidString
      
      FIRStorage.storage().reference().child("profile_images").child(filename)
        .put(uploadData, metadata: nil, completion: { metadata, error in
          if let error = error {
            print("Faild to upload profile image", error)
            return
          }
          
          guard let profileImageURL = metadata?.downloadURL()?.absoluteString else { return }
          print("Successfully uploaded profile image:", profileImageURL)
          
          guard let uid = user?.uid else { return }
          
          let dictionaryValues = ["username": username, "profileImageURL": profileImageURL]
          let values = [uid: dictionaryValues]
          
          FIRDatabase.database().reference().child("users")
            .updateChildValues(values, withCompletionBlock: { error, ref in
              if let error = error {
                print("Failed to save user info to database:", error)
              }
              print("Successfully to save user info to database")
              
              AppDelegate.instance?.presentMainScreen()
            })
        })
    })
    
  }
  
  func plusPhotoButtonDidTap() {
    let imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    imagePickerController.allowsEditing = true
    
    self.present(imagePickerController, animated: true, completion: nil)
  }
  
  fileprivate dynamic func alreadyHaveAccountButtonDidTap() {
    _ = self.navigationController?.popViewController(animated: true)
  }
  
}


// MARK: - UIImagePickerControllerDelegate

extension SignUpViewController: UIImagePickerControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
      self.plusPhotoButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
    } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
      self.plusPhotoButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    self.plusPhotoButton.layer.cornerRadius = self.plusPhotoButton.frame.width/2
    self.plusPhotoButton.layer.masksToBounds = true
    self.plusPhotoButton.layer.borderColor = UIColor.black.cgColor
    self.plusPhotoButton.layer.borderWidth = 2
    
    self.dismiss(animated: true, completion: nil)
  }
  
}

// MARK: - UINavigationControllerDelegate

extension SignUpViewController: UINavigationControllerDelegate {
  
}

