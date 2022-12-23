//
//  RegisterViewController.swift
//  Weather app
//
//  Created by praksa on 15.11.22..
//

import UIKit
import FirebaseAuth
import Firebase
import Resolver

class RegisterViewController: UIViewController {
    
    @Injected var databaseService: DatabaseService

    let registerView = RegisterView()
    let validate = ValidationFields()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        view = registerView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.setBackgroundGradient()
    }
    
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            registerView.registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    @objc private func registerButtonTapped() {
        
        if let email = registerView.emailRegisterTextField.text, let password = registerView.passwordRegisterTextField.text, let repeatPassword = registerView.confirmPasswordRegisterTextField.text {
            
            let (isValid, errMessage) = validate.createAccountValdiation(email: email, password: password, repeatPassword: repeatPassword)
            
            if isValid {
                databaseService.register(email: email, password: password) { [self] result in
                    switch result {
                    case .success(_):
                        databaseService.setUserDefaultUnitSystem(email: email)
                        guard let tabBar = parent?.parent as? TabBarViewController else { return }
                        tabBar.selectedIndex = 0
                        navigationController?.popToRootViewController(animated: true)
                    case .failure(let error):
                        registerView.errorMessage.text = error.localizedDescription
                        registerView.errorMessage.isHidden = false
                    }
                }
            } else {
                registerView.errorMessage.text = errMessage
                registerView.errorMessage.isHidden = false
            }
        }
    }
    

}
