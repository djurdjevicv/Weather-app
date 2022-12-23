//
//  WelcomeViewController.swift
//  Weather app
//
//  Created by praksa on 7.11.22..
//

import UIKit

class WelcomeViewController: UIViewController {
    
    private let welcomeView = WelcomeView()
        
    override func loadView() {
        view = welcomeView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.setBackgroundGradient()
    }
    
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            welcomeView.getStartedButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        let tabBar = TabBarViewController()
        tabBar.modalPresentationStyle = .fullScreen
        self.present(tabBar, animated: false, completion: nil)
        UserDefaults.standard.set(true, forKey: Constants.termsAccepted)

    }
    
    
}

