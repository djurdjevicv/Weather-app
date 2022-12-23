//
//  LoginView.swift
//  Weather app
//
//  Created by praksa on 15.11.22..
//

import UIKit

class LoginView: UIView {
    
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
    
    lazy var loginTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "Sign in"
        view.font = UIFont.boldSystemFont(ofSize: 25.0)
        view.accessibilityIdentifier = "text_view_create_account"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var loginSubtitleLabel: UILabel = {
        let view = UILabel()
        view.text = "Easy steps to predict the weather and make your day easier"
        view.font = UIFont.boldSystemFont(ofSize: 15.0)
        view.accessibilityIdentifier = "text_view_description"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var emailLoginTextField: UITextField = {
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
    
    lazy var emailLoginTextFieldIcon: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(named: "emailIcon")
        view.alpha = 0.4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var passwordLoginTextField: UITextField = {
        let view = UITextField()
        view.accessibilityIdentifier = "edit_text_password"
        view.leftView = passwordLeftView
        view.leftViewMode = .always
        view.isSecureTextEntry = true
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.attributedPlaceholder = NSAttributedString(string: "Password", attributes:[NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.4)])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var passwordLoginTextFieldIcon: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(named: "passwordIcon")
        view.alpha = 0.4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var loginButton: UIButton = {
        let view = UIButton()
        view.setTitle("Login", for: .normal)
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        view.accessibilityIdentifier = "button_login"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var errorMessage: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indictor = UIActivityIndicatorView()
        indictor.translatesAutoresizingMaskIntoConstraints = false
        indictor.color = .white
        return indictor
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
        setBackgroundGradient()
    }
    
    private func setupView() {
        addSubview(imageView)
        addSubview(loginTitleLabel)
        addSubview(loginSubtitleLabel)
        addSubview(emailLoginTextField)
        emailLoginTextField.addSubview(emailLeftView)
        emailLeftView.addSubview(emailLoginTextFieldIcon)
        addSubview(passwordLoginTextField)
        passwordLoginTextField.addSubview(passwordLeftView)
        passwordLeftView.addSubview(passwordLoginTextFieldIcon)
        addSubview(errorMessage)
        addSubview(loginButton)
        addSubview(activityIndicator)
        
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        imageView.heightAnchor.constraint(lessThanOrEqualToConstant: 130).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 97).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -97).isActive = true
        
        loginTitleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        loginTitleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30).isActive = true
        loginTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        loginTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24).isActive = true
        
        loginSubtitleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginSubtitleLabel.topAnchor.constraint(equalTo: loginTitleLabel.bottomAnchor, constant: 10).isActive = true
        loginSubtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 44).isActive = true
        loginSubtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -44).isActive = true
        
        emailLoginTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        emailLoginTextField.topAnchor.constraint(equalTo: loginSubtitleLabel.bottomAnchor, constant: 50).isActive = true
        emailLoginTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35).isActive = true
        emailLoginTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35).isActive = true
        
        emailLeftView.leadingAnchor.constraint(equalTo: emailLoginTextField.leadingAnchor, constant: 10).isActive = true
        emailLeftView.widthAnchor.constraint(equalToConstant: 45).isActive = true
        emailLeftView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        emailLeftView.centerYAnchor.constraint(equalTo: emailLoginTextField.centerYAnchor).isActive = true
        
        emailLoginTextFieldIcon.leadingAnchor.constraint(equalTo: emailLeftView.leadingAnchor, constant: 10).isActive = true
        emailLoginTextFieldIcon.trailingAnchor.constraint(equalTo: emailLeftView.trailingAnchor, constant: -10).isActive = true
        emailLoginTextFieldIcon.topAnchor.constraint(equalTo: emailLeftView.topAnchor, constant: 10).isActive = true
        emailLoginTextFieldIcon.bottomAnchor.constraint(equalTo: emailLeftView.bottomAnchor, constant: -10).isActive = true
        
        passwordLoginTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        passwordLoginTextField.topAnchor.constraint(equalTo: emailLoginTextField.bottomAnchor, constant: 20).isActive = true
        passwordLoginTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35).isActive = true
        passwordLoginTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35).isActive = true
        
        emailLeftView.leadingAnchor.constraint(equalTo: emailLoginTextField.leadingAnchor, constant: 10).isActive = true
        emailLeftView.widthAnchor.constraint(equalToConstant: 45).isActive = true
        emailLeftView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        emailLeftView.centerYAnchor.constraint(equalTo: emailLoginTextField.centerYAnchor).isActive = true
        
        passwordLeftView.leadingAnchor.constraint(equalTo: passwordLoginTextField.leadingAnchor, constant: 10).isActive = true
        passwordLeftView.widthAnchor.constraint(equalToConstant: 45).isActive = true
        passwordLeftView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        passwordLeftView.centerYAnchor.constraint(equalTo: passwordLoginTextField.centerYAnchor).isActive = true
        
        passwordLoginTextFieldIcon.leadingAnchor.constraint(equalTo: passwordLeftView.leadingAnchor, constant: 10).isActive = true
        passwordLoginTextFieldIcon.trailingAnchor.constraint(equalTo: passwordLeftView.trailingAnchor, constant: -10).isActive = true
        passwordLoginTextFieldIcon.topAnchor.constraint(equalTo: passwordLeftView.topAnchor, constant: 10).isActive = true
        passwordLoginTextFieldIcon.bottomAnchor.constraint(equalTo: passwordLeftView.bottomAnchor, constant: -10).isActive = true
        
        emailLeftView.leadingAnchor.constraint(equalTo: emailLoginTextField.leadingAnchor, constant: 10).isActive = true
        emailLeftView.widthAnchor.constraint(equalToConstant: 45).isActive = true
        emailLeftView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        emailLeftView.centerYAnchor.constraint(equalTo: emailLoginTextField.centerYAnchor).isActive = true
        
        errorMessage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        errorMessage.topAnchor.constraint(equalTo: passwordLoginTextField.bottomAnchor, constant: 10).isActive = true

        loginButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
        loginButton.topAnchor.constraint(equalTo: passwordLoginTextField.bottomAnchor, constant: 45).isActive = true
        loginButton.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
    }
    
    private func styleView() {
        loginTitleLabel.textColor = .white
        loginTitleLabel.textAlignment = .center
        loginTitleLabel.adjustsFontSizeToFitWidth = true;
        loginTitleLabel.minimumScaleFactor = 0.5
        
        loginSubtitleLabel.numberOfLines = 0
        loginSubtitleLabel.textColor = UIColor(red: 0.908, green: 0.829, blue: 0.829, alpha: 1)
        loginSubtitleLabel.textAlignment = .center
        loginSubtitleLabel.minimumScaleFactor = 0.5
        loginSubtitleLabel.adjustsFontSizeToFitWidth = true;
        
        emailLoginTextField.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        emailLoginTextField.layer.cornerRadius = 50/2
        emailLoginTextField.textColor = .white
        
        passwordLoginTextField.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        passwordLoginTextField.layer.cornerRadius = 50/2
        passwordLoginTextField.textColor = .white
        
        loginButton.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        loginButton.layer.cornerRadius = 48/2
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        loginButton.sizeToFit()
        
        errorMessage.textColor = .red
        
        activityIndicator.transform = CGAffineTransform(scaleX: 2, y: 2)

    }
    
}
