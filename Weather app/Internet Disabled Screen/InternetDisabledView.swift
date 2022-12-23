//
//  InternetDisabledView.swift
//  Weather app
//
//  Created by Vladimir Djurdjevic on 12.12.22..
//

import UIKit

class InternetDisabledView: UIView {

    lazy var centeredView: UIView = {
        let view = UIView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var disabledWiFiIcon: UIImageView = {
        let image = UIImageView()
        let config = UIImage.SymbolConfiguration(
            pointSize: 50, weight: .medium, scale: .default)
        image.image = UIImage(systemName: "wifi.slash", withConfiguration: config)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var mainTitle: UILabel = {
        let label = UILabel()
        label.text = "Weather Unavailable"
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descriptionTitle: UILabel = {
        let label = UILabel()
        label.text = "The Weather app isn't connected to the internet. To view weather, check your connection, then try again."
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var actionTitle: UILabel = {
        let label = UILabel()
        label.text = "Go to Settings"
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
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
        setBackgroundGradient()
    }
    
    private func setupView() {
        addSubview(centeredView)
        centeredView.addSubview(disabledWiFiIcon)
        centeredView.addSubview(mainTitle)
        centeredView.addSubview(descriptionTitle)
        centeredView.addSubview(actionTitle)
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        centeredView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        centeredView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        centeredView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        centeredView.trailingAnchor.constraint(equalTo: leadingAnchor, constant: -10).isActive = true
        centeredView.widthAnchor.constraint(equalToConstant: screenWidth).isActive = true
        centeredView.heightAnchor.constraint(equalToConstant: screenWidth).isActive = true

        disabledWiFiIcon.topAnchor.constraint(equalTo: centeredView.topAnchor).isActive = true
        disabledWiFiIcon.centerXAnchor.constraint(equalTo: centeredView.centerXAnchor).isActive = true
        
        mainTitle.topAnchor.constraint(equalTo: disabledWiFiIcon.bottomAnchor, constant: 10).isActive = true
        mainTitle.centerXAnchor.constraint(equalTo: centeredView.centerXAnchor).isActive = true

        descriptionTitle.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 5).isActive = true
        descriptionTitle.centerXAnchor.constraint(equalTo: centeredView.centerXAnchor).isActive = true
        descriptionTitle.leadingAnchor.constraint(equalTo: centeredView.leadingAnchor).isActive = true
        descriptionTitle.trailingAnchor.constraint(equalTo: centeredView.trailingAnchor).isActive = true
        
        actionTitle.topAnchor.constraint(equalTo: descriptionTitle.bottomAnchor, constant: 15).isActive = true
        actionTitle.centerXAnchor.constraint(equalTo: centeredView.centerXAnchor).isActive = true

    }
    
    private func styleView() {
                
        disabledWiFiIcon.tintColor = .white.withAlphaComponent(0.5)
        
        mainTitle.textColor = .white
        
        descriptionTitle.numberOfLines = 3
        descriptionTitle.textColor = .white.withAlphaComponent(0.5)
        descriptionTitle.textAlignment = .center

        actionTitle.textColor = .white
    }

}



