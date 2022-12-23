//
//  LoginViewController.swift
//  Weather app
//
//  Created by praksa on 15.11.22..
//

import UIKit
import FirebaseAuth
import Resolver
import FirebaseFirestore

class LoginViewController: UIViewController {

    @Injected var databaseService: DatabaseService
    
    let loginView = LoginView()
    let validate = ValidationFields()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view = loginView
        view.setBackgroundGradient()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.setBackgroundGradient()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loginView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    func getFavoriteLocation(email: String) {
        databaseService.getFavouriteLocation(email: email) { result in
            switch result {
            case .success(let listFavouriteLocations):

                UserDefaults.favoriteLocations = listFavouriteLocations
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getUnitSystem(email: String){
        databaseService.getUserUnitSystem(email: email) { result in
            switch result {
            case .success(let unitSystem):
                UserDefaults.unitSystem = unitSystem
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func setDataForLogin() {
        
        UserDefaults.selectedFavoriteLocation = nil
        
    }
    
    @objc private func loginButtonTapped() {
        
        if let email = loginView.emailLoginTextField.text, let password = loginView.passwordLoginTextField.text {
            
            let (isValid, errMessage) = validate.loginValidation(email: email, password: password)
            
            if isValid {
                loginView.activityIndicator.startAnimating()
                databaseService.login(email: email, password: password) { [self] result in
                    switch result {
                    case .success(_):
                        print("Success login")
                        getFavoriteLocation(email: email)
                        getUnitSystem(email: email)
                        guard let tabBar = parent?.parent as? TabBarViewController else { return }
                        tabBar.selectedIndex = 0
                        loginView.activityIndicator.stopAnimating()
                        navigationController?.popToRootViewController(animated: true)
                    case .failure(let error):
                        print(error)
                        loginView.activityIndicator.stopAnimating()
                        loginView.errorMessage.text = "Invalid email or password"
                        loginView.errorMessage.isHidden = false
                    }
                }
            } else {
                loginView.errorMessage.text = errMessage
                loginView.errorMessage.isHidden = false
            }
        }
    }
    
}
