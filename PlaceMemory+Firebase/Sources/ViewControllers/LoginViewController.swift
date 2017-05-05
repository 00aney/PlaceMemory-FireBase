//
//  LoginViewController.swift
//  PlaceMemory+Firebase
//
//  Created by aney on 2017. 5. 5..
//  Copyright © 2017년 Taedong Kim. All rights reserved.
//

import UIKit

import Firebase

class LoginViewController: UIViewController {
  
  // MARK: Constants
  
  struct Metric {
    static let titleLabelTop = 40.f
    static let stackViewLeft = 40.f
    static let stackViewRight = 40.f
    static let stackViewHeight = 150.f
  }
  
  struct Font {
    static let titleLabelField = UIFont.systemFont(ofSize: 30)
    static let textField = UIFont.systemFont(ofSize: 14)
    static let signUpButton = UIFont.boldSystemFont(ofSize: 14)
  }
  
  struct Color {
    static let loginButtonBackground = UIColor.rgb(red: 149, green: 204, blue: 244)
    static let loginButtonEnabled = UIColor.rgb(red: 17, green: 154, blue: 237)
    static let loginButtonUnabled = UIColor.rgb(red: 149, green: 204, blue: 244)
    
  }
  
  
  // MARK: UI
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "로그인"
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = Font.titleLabelField
    label.textAlignment = .center
    return label
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
  
  let loginButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Login", for: .normal)
    button.backgroundColor = Color.loginButtonBackground
    button.layer.cornerRadius = 5
    button.titleLabel?.font = Font.signUpButton
    button.setTitleColor(.white, for: .normal)
    button.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
    button.isEnabled = false
    return button
  }()
  
  let dontHaveAccountButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("계정이 없으신가요?  회원가입", for: .normal)
    button.addTarget(self, action: #selector(dontHaveAccountButtonDidTap), for: .touchUpInside)
    return button
  }()
  
  
  // MARK: View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .white
    
    self.navigationController?.isNavigationBarHidden = true
    
    self.view.addSubview(self.titleLabel)
    self.titleLabel.anchor(top: self.view.topAnchor, left: self.view.leftAnchor, bottom: nil, right: self.view.rightAnchor, paddingTop: Metric.titleLabelTop, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 40)
    
    self.setupInputFields()
    
    self.view.addSubview(self.dontHaveAccountButton)
    self.dontHaveAccountButton.anchor(top: nil, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 30)
  }
  
  // MARK: Layout
  
  fileprivate func setupInputFields() {
    let stackView = UIStackView(
      arrangedSubviews: [
        self.emailTextField,
        self.passwordTextField,
        self.loginButton,
        ]
    )
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.distribution = .fillEqually
    stackView.axis = .vertical
    stackView.spacing = 10
    
    self.view.addSubview(stackView)
    
    stackView.anchor(top: self.titleLabel.bottomAnchor, left: self.view.leftAnchor, bottom: nil, right: self.view.rightAnchor, paddingTop: 20, paddingLeft: Metric.stackViewLeft, paddingBottom: 0, paddingRight: Metric.stackViewRight, width: 0, height: Metric.stackViewHeight)
  }
  
  
  // MARK: Actions
  
  fileprivate dynamic func dontHaveAccountButtonDidTap() {
    self.navigationController?.pushViewController(SignUpViewController(), animated: true)
  }
  
  fileprivate dynamic func handleTextInputChange() {
    let isFormValid = self.emailTextField.text?.characters.count ?? 0 > 0 &&
      self.emailTextField.text?.contains("@") ?? false &&
      self.passwordTextField.text?.characters.count ?? 0 > 0
    
    if isFormValid {
      self.loginButton.isEnabled = true
      self.loginButton.backgroundColor = Color.loginButtonEnabled
    } else {
      self.loginButton.isEnabled = false
      self.loginButton.backgroundColor = Color.loginButtonUnabled
    }
  }
  
  fileprivate dynamic func loginButtonDidTap() {
    guard let email = self.emailTextField.text, email.characters.count > 0 else { return }
    guard let password = self.passwordTextField.text, password.characters.count > 0 else { return }
    
    FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { user, error in
      if let error = error {
        print("Failed to login:", error)
        return
      }
      
      AppDelegate.instance?.presentMainScreen()
    })
  }
  
}
