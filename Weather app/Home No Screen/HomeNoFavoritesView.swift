//
//  HomeNoFavoritesView.swift
//  Weather app
//
//  Created by praksa on 18.11.22..
//

import UIKit

class HomeNoFavoritesView: UIView {
    
    lazy var alertImageView: UIView = {
        let view = UIView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var alertImageIcon_1: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "alertIcon")
        view.alpha = 0.3
        view.accessibilityIdentifier = "image_weatherIcon"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var alertImageIcon_2: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "alertIcon_2")
        view.alpha = 0.6
        view.contentMode = .scaleAspectFit
        view.accessibilityIdentifier = "image_weatherIcon"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var subtitleAlertLabel: UILabel = {
        let view = UILabel()
        view.text = "You don’t have favorite locations yet. Please add your favorite locations."
        view.font = UIFont.boldSystemFont(ofSize: 15.0)
        view.accessibilityIdentifier = "text_subtitle"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var searchLocationsButton: UIButton = {
        let view = UIButton()
        view.setTitle("Search locations", for: .normal)
        view.accessibilityIdentifier = "button_getStarted"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        addSubview(alertImageView)
        alertImageView.addSubview(alertImageIcon_1)
        alertImageIcon_1.addSubview(alertImageIcon_2)
        addSubview(subtitleAlertLabel)
        addSubview(searchLocationsButton)
        
        alertImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        alertImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        alertImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 220).isActive = true
        
        alertImageIcon_1.widthAnchor.constraint(equalToConstant: 70).isActive = true
        alertImageIcon_1.heightAnchor.constraint(equalToConstant: 70).isActive = true
        alertImageIcon_1.leadingAnchor.constraint(equalTo: alertImageView.leadingAnchor).isActive = true
        alertImageIcon_1.trailingAnchor.constraint(equalTo: alertImageView.trailingAnchor).isActive = true
        alertImageIcon_1.topAnchor.constraint(equalTo: alertImageView.topAnchor).isActive = true
        
        alertImageIcon_2.centerXAnchor.constraint(equalTo: alertImageIcon_1.centerXAnchor).isActive = true
        alertImageIcon_2.widthAnchor.constraint(equalToConstant: 10).isActive = true
        alertImageIcon_2.bottomAnchor.constraint(equalTo: alertImageIcon_1.bottomAnchor, constant: -15).isActive = true
        alertImageIcon_2.topAnchor.constraint(equalTo: alertImageIcon_1.topAnchor, constant: 22).isActive = true
        
        subtitleAlertLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        subtitleAlertLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -45).isActive = true
        subtitleAlertLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 45).isActive = true
        subtitleAlertLabel.topAnchor.constraint(equalTo: alertImageView.bottomAnchor, constant: 80).isActive = true
        
        searchLocationsButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        searchLocationsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -90).isActive = true
        searchLocationsButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 90).isActive = true
        searchLocationsButton.topAnchor.constraint(equalTo: subtitleAlertLabel.bottomAnchor, constant: 30).isActive = true
    }
    
    private func styleView() {
        subtitleAlertLabel.numberOfLines = 2
        subtitleAlertLabel.textColor = UIColor(red: 0.908, green: 0.829, blue: 0.829, alpha: 0.7)
        subtitleAlertLabel.textAlignment = .center
        subtitleAlertLabel.minimumScaleFactor = 0.5
        subtitleAlertLabel.adjustsFontSizeToFitWidth = true;
        
        searchLocationsButton.backgroundColor = .white
        searchLocationsButton.layer.cornerRadius = 48/2
        searchLocationsButton.setTitleColor(UIColor.gray, for: .normal)
        searchLocationsButton.sizeToFit()
    }
    
    
}
