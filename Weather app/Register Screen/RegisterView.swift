//
//  RegisterView.swift
//  Weather app
//
//  Created by praksa on 15.11.22..
//

import UIKit

class RegisterView: UIView {
    
    var gradient = CAGradientLayer()
    let color = UIColor.white.withAlphaComponent(0.4)
    lazy var emailLeftView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var passwordLeftView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var confirmPasswordLeftView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "logo")
        view.accessibilityIdentifier = "image_view_logo"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var registerTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "Create an account"
        view.font = UIFont.boldSystemFont(ofSize: 25.0)
        view.accessibilityIdentifier = "text_view_create_account"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var registerSubtitleLabel: UILabel = {
        let view = UILabel()
        view.text = "Easy steps to predict the weather and make your day easier"
        view.font = UIFont.boldSystemFont(ofSize: 15.0)
        view.accessibilityIdentifier = "text_view_description"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var emailRegisterTextField: UITextField = {
        let view = UITextField()
        view.accessibilityIdentifier = "edit_text_email"
        view.leftView = emailLeftView
        view.leftViewMode = .always
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.attributedPlaceholder = NSAttributedString(string: "Email address", attributes:[NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.4)])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var emailRegisterTextFieldIcon: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(named: "emailIcon")
        view.alpha = 0.4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var passwordRegisterTextField: UITextField = {
        let view = UITextField()
        view.accessibilityIdentifier = "edit_text_password"
        view.leftView = passwordLeftView
        view.isSecureTextEntry = true
        view.leftViewMode = .always
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.attributedPlaceholder = NSAttributedString(string: "Password", attributes:[NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.4)])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var passwordRegisterTextFieldIcon: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(named: "passwordIcon")
        view.alpha = 0.4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var confirmPasswordRegisterTextField: UITextField = {
        let view = UITextField()
        view.accessibilityIdentifier = "edit_text_confirm_password"
        view.leftView = confirmPasswordLeftView
        view.isSecureTextEntry = true
        view.leftViewMode = .always
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.attributedPlaceholder = NSAttributedString(string: "Confirm password", attributes:[NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.4)])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var confirmPasswordRegisterTextFieldIcon: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(named: "passwordIcon")
        view.alpha = 0.4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var registerButton: UIButton = {
        let view = UIButton()
        view.setTitle("Register", for: .normal)
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        view.accessibilityIdentifier = "button_register"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var errorMessage: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        
        setupView()
        styleView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setupView() {
        addSubview(imageView)
        addSubview(registerTitleLabel)
        addSubview(registerSubtitleLabel)
        addSubview(emailRegisterTextField)
        emailRegisterTextField.addSubview(emailLeftView)
        emailLeftView.addSubview(emailRegisterTextFieldIcon)
        addSubview(passwordRegisterTextField)
        passwordRegisterTextField.addSubview(passwordLeftView)
        passwordLeftView.addSubview(passwordRegisterTextFieldIcon)
        addSubview(confirmPasswordRegisterTextField)
        confirmPasswordRegisterTextField.addSubview(confirmPasswordLeftView)
        confirmPasswordLeftView.addSubview(confirmPasswordRegisterTextFieldIcon)
        addSubview(errorMessage)
        addSubview(registerButton)
        
        imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        imageView.heightAnchor.constraint(lessThanOrEqualToConstant: 130).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 97).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -97).isActive = true
        
        
        registerTitleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        registerTitleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30).isActive = true
        registerTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        registerTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24).isActive = true
        
        registerSubtitleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        registerSubtitleLabel.topAnchor.constraint(equalTo: registerTitleLabel.bottomAnchor, constant: 10).isActive = true
        registerSubtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 44).isActive = true
        registerSubtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -44).isActive = true
        
        
        emailRegisterTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        emailRegisterTextField.topAnchor.constraint(equalTo: registerSubtitleLabel.bottomAnchor, constant: 50).isActive = true
        emailRegisterTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35).isActive = true
        emailRegisterTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35).isActive = true
        
        emailLeftView.leadingAnchor.constraint(equalTo: emailRegisterTextField.leadingAnchor, constant: 10).isActive = true
        emailLeftView.widthAnchor.constraint(equalToConstant: 45).isActive = true
        emailLeftView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        emailLeftView.centerYAnchor.constraint(equalTo: emailRegisterTextField.centerYAnchor).isActive = true
        
        emailRegisterTextFieldIcon.leadingAnchor.constraint(equalTo: emailLeftView.leadingAnchor, constant: 10).isActive = true
        emailRegisterTextFieldIcon.trailingAnchor.constraint(equalTo: emailLeftView.trailingAnchor, constant: -10).isActive = true
        emailRegisterTextFieldIcon.topAnchor.constraint(equalTo: emailLeftView.topAnchor, constant: 10).isActive = true
        emailRegisterTextFieldIcon.bottomAnchor.constraint(equalTo: emailLeftView.bottomAnchor, constant: -10).isActive = true
        
        passwordRegisterTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        passwordRegisterTextField.topAnchor.constraint(equalTo: emailRegisterTextField.bottomAnchor, constant: 20).isActive = true
        passwordRegisterTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35).isActive = true
        passwordRegisterTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35).isActive = true
        
        emailLeftView.leadingAnchor.constraint(equalTo: emailRegisterTextField.leadingAnchor, constant: 10).isActive = true
        emailLeftView.widthAnchor.constraint(equalToConstant: 45).isActive = true
        emailLeftView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        emailLeftView.centerYAnchor.constraint(equalTo: emailRegisterTextField.centerYAnchor).isActive = true
        
        passwordLeftView.leadingAnchor.constraint(equalTo: passwordRegisterTextField.leadingAnchor, constant: 10).isActive = true
        passwordLeftView.widthAnchor.constraint(equalToConstant: 45).isActive = true
        passwordLeftView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        passwordLeftView.centerYAnchor.constraint(equalTo: passwordRegisterTextField.centerYAnchor).isActive = true
        
        passwordRegisterTextFieldIcon.leadingAnchor.constraint(equalTo: passwordLeftView.leadingAnchor, constant: 10).isActive = true
        passwordRegisterTextFieldIcon.trailingAnchor.constraint(equalTo: passwordLeftView.trailingAnchor, constant: -10).isActive = true
        passwordRegisterTextFieldIcon.topAnchor.constraint(equalTo: passwordLeftView.topAnchor, constant: 10).isActive = true
        passwordRegisterTextFieldIcon.bottomAnchor.constraint(equalTo: passwordLeftView.bottomAnchor, constant: -10).isActive = true
        
        confirmPasswordRegisterTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        confirmPasswordRegisterTextField.topAnchor.constraint(equalTo: passwordRegisterTextField.bottomAnchor, constant: 20).isActive = true
        confirmPasswordRegisterTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35).isActive = true
        confirmPasswordRegisterTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35).isActive = true
        
        emailLeftView.leadingAnchor.constraint(equalTo: emailRegisterTextField.leadingAnchor, constant: 10).isActive = true
        emailLeftView.widthAnchor.constraint(equalToConstant: 45).isActive = true
        emailLeftView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        emailLeftView.centerYAnchor.constraint(equalTo: emailRegisterTextField.centerYAnchor).isActive = true
        
        confirmPasswordLeftView.leadingAnchor.constraint(equalTo: confirmPasswordRegisterTextField.leadingAnchor, constant: 10).isActive = true
        confirmPasswordLeftView.widthAnchor.constraint(equalToConstant: 45).isActive = true
        confirmPasswordLeftView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        confirmPasswordLeftView.centerYAnchor.constraint(equalTo: confirmPasswordRegisterTextField.centerYAnchor).isActive = true
        
        confirmPasswordRegisterTextFieldIcon.leadingAnchor.constraint(equalTo: confirmPasswordLeftView.leadingAnchor, constant: 10).isActive = true
        confirmPasswordRegisterTextFieldIcon.trailingAnchor.constraint(equalTo: confirmPasswordLeftView.trailingAnchor, constant: -10).isActive = true
        confirmPasswordRegisterTextFieldIcon.topAnchor.constraint(equalTo: confirmPasswordLeftView.topAnchor, constant: 10).isActive = true
        confirmPasswordRegisterTextFieldIcon.bottomAnchor.constraint(equalTo: confirmPasswordLeftView.bottomAnchor, constant: -10).isActive = true
        
        errorMessage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        errorMessage.topAnchor.constraint(equalTo: confirmPasswordRegisterTextField.bottomAnchor, constant: 10).isActive = true
        errorMessage.widthAnchor.constraint(equalToConstant: 300).isActive = true

        registerButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        registerButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
        registerButton.topAnchor.constraint(equalTo: confirmPasswordRegisterTextField.bottomAnchor, constant: 48).isActive = true
        registerButton.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        
    }
    
    private func styleView() {
        registerTitleLabel.textColor = .white
        registerTitleLabel.textAlignment = .center
        registerTitleLabel.adjustsFontSizeToFitWidth = true;
        registerTitleLabel.minimumScaleFactor = 0.5
        
        registerSubtitleLabel.numberOfLines = 0
        registerSubtitleLabel.textColor = UIColor(red: 0.908, green: 0.829, blue: 0.829, alpha: 1)
        registerSubtitleLabel.textAlignment = .center
        registerSubtitleLabel.minimumScaleFactor = 0.5
        registerSubtitleLabel.adjustsFontSizeToFitWidth = true;
        
        emailRegisterTextField.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        emailRegisterTextField.layer.cornerRadius = 50/2
        emailRegisterTextField.textColor = .white
        
        passwordRegisterTextField.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        passwordRegisterTextField.layer.cornerRadius = 50/2
        passwordRegisterTextField.textColor = .white
        
        confirmPasswordRegisterTextField.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        confirmPasswordRegisterTextField.layer.cornerRadius = 50/2
        confirmPasswordRegisterTextField.textColor = .white
        
        registerButton.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        registerButton.layer.cornerRadius = 48/2
        registerButton.setTitleColor(UIColor.white, for: .normal)
        registerButton.sizeToFit()
        
        errorMessage.textColor = .red
    }
    
}


