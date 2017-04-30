//
//  ViewController.swift
//  PlaceMemory+Firebase
//
//  Created by aney on 2017. 5. 1..
//  Copyright © 2017년 Taedong Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
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
    static let signUpButtonBackground = UIColor(colorLiteralRed: 149/255, green: 204/255, blue: 244/255, alpha: 1)
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
    return button
  }()
  
  let emailTextField: UITextField = {
    let tf = UITextField()
    tf.placeholder = "Email"
    tf.translatesAutoresizingMaskIntoConstraints = false
    tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
    tf.font = Font.textField
    tf.borderStyle = .roundedRect
    return tf
  }()
  
  let usernameTextField: UITextField = {
    let tf = UITextField()
    tf.placeholder = "Username"
    tf.translatesAutoresizingMaskIntoConstraints = false
    tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
    tf.font = Font.textField
    tf.borderStyle = .roundedRect
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
    return tf
  }()
  
  let signUpbutton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Sign Up", for: .normal)
    button.backgroundColor = Color.signUpButtonBackground
    button.layer.cornerRadius = 5
    button.titleLabel?.font = Font.signUpButton
    button.setTitleColor(.white, for: .normal)
    return button
  }()
  
  
  // MARK: View Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    
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
  }
  
  
  // MARK: Layout
  
  fileprivate func setupInputFields() {
    let stackView = UIStackView(
      arrangedSubviews: [
        self.emailTextField,
        self.usernameTextField,
        self.passwordTextField,
        self.signUpbutton,
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
  
}
