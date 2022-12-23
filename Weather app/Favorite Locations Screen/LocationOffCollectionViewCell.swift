//
//  LocationOffCollectionViewCell.swift
//  Weather app
//
//  Created by praksa on 21.11.22..
//

import UIKit

class LocationOffCollectionViewCell: UICollectionViewCell {
        
    lazy var locationViewLocationOff: UIView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 30
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Provide your \ncurrent location"
        label.numberOfLines = 2
        label.font = label.font.withSize(14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var backgroundImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "location_pin")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        styleView()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {

        addSubview(locationViewLocationOff)
        locationViewLocationOff.addSubview(backgroundImage)
        locationViewLocationOff.addSubview(titleLabel)
        
        locationViewLocationOff.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        locationViewLocationOff.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -0).isActive = true
        locationViewLocationOff.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        locationViewLocationOff.heightAnchor.constraint(equalToConstant: 160).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: locationViewLocationOff.leadingAnchor, constant: 17).isActive = true
        titleLabel.topAnchor.constraint(equalTo: locationViewLocationOff.topAnchor, constant: 58).isActive = true
        
        backgroundImage.leadingAnchor.constraint(equalTo: locationViewLocationOff.leadingAnchor, constant: 20).isActive = true
        backgroundImage.trailingAnchor.constraint(equalTo: locationViewLocationOff.trailingAnchor, constant: -25).isActive = true
        backgroundImage.topAnchor.constraint(equalTo: locationViewLocationOff.topAnchor, constant: 10).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: locationViewLocationOff.bottomAnchor, constant: -10).isActive = true
        backgroundImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func styleView() {

        locationViewLocationOff.backgroundColor = .black.withAlphaComponent(0.2)
        backgroundImage.alpha = 0.2
                
        titleLabel.textColor = .white
    }
    
}
