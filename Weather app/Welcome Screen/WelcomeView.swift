//
//  WelcomeView.swift
//  Weather app
//
//  Created by praksa on 7.11.22..
//

import UIKit

class WelcomeView: UIView {
    
    var gradient = CAGradientLayer()
    
    lazy var imageView: UIImageView = {
            let view = UIImageView()
            view.image = UIImage(named: "logo")
            view.accessibilityIdentifier = "image_weatherIcon"
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
    
    lazy var titleLabel: UILabel = {
            let view = UILabel()
            view.text = "Find weather prediction in your city"
            view.accessibilityIdentifier = "text_title"
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
    
    lazy var subtitleLabel: UILabel = {
            let view = UILabel()
            view.text = "Easy steps to predict the weather and make your day easier"
            view.accessibilityIdentifier = "text_subtitle"
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
    
    lazy var getStartedButton: UIButton = {
            let view = UIButton()
            view.setTitle("Get started", for: .normal)
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
        gradient.frame = bounds
    }
    
    private func setupView() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(getStartedButton)
        
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 180).isActive = true
        imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true

        
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 60).isActive = true
        
        subtitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        subtitleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        subtitleLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        
        getStartedButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        getStartedButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        getStartedButton.widthAnchor.constraint(equalToConstant: 154).isActive = true
        getStartedButton.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 30).isActive = true
    }
    
    private func styleView() {
        
        titleLabel.numberOfLines = 2
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30.0)
        titleLabel.textAlignment = .center
        titleLabel.adjustsFontSizeToFitWidth = true;
        titleLabel.minimumScaleFactor = 0.5
        
        subtitleLabel.numberOfLines = 2
        subtitleLabel.textColor = UIColor(red: 0.908, green: 0.829, blue: 0.829, alpha: 1)
        subtitleLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
        subtitleLabel.textAlignment = .center
        subtitleLabel.minimumScaleFactor = 0.5
        subtitleLabel.adjustsFontSizeToFitWidth = true;
        
        getStartedButton.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        getStartedButton.layer.cornerRadius = 48/2
        getStartedButton.setTitleColor(UIColor.white, for: .normal)
        getStartedButton.sizeToFit()
    }
    
}

