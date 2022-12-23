//
//  FavoriteLocationCollectionViewCell.swift
//  Weather app
//
//  Created by praksa on 18.11.22..
//

import UIKit

class FavoriteLocationCollectionViewCell: UICollectionViewCell {
    
    lazy var locationView: UIView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 30
        return view
    }()
    
    lazy var backgroundImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "location_pin")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(36)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var humidityIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "humidityIcon")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var humidityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(12)
        label.accessibilityIdentifier = "text_humidity"
        return label
    }()
    
    private lazy var windIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "windIcon")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.accessibilityIdentifier = "text_windSpeed"
        return view
    }()
    
    lazy var windLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(12)
        return label
    }()
    
    lazy var weatherIcon: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var deleteImage: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "deleteIcon"), for: .normal)
        view.imageEdgeInsets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        backgroundImage.isHidden = true
        locationView.backgroundColor = .white.withAlphaComponent(0.2)
        locationView.layer.borderWidth = 0.0
        cityLabel.text = ""
        temperatureLabel.text = ""
        countryLabel.text = ""
        windLabel.text = ""
    }
    
    private func setupView() {

        addSubview(locationView)
        locationView.addSubview(backgroundImage)
        locationView.addSubview(temperatureLabel)
        locationView.addSubview(cityLabel)
        locationView.addSubview(countryLabel)
        
        locationView.addSubview(humidityIcon)
        locationView.addSubview(humidityLabel)
        
        locationView.addSubview(windIcon)
        locationView.addSubview(windLabel)
        locationView.addSubview(weatherIcon)
        locationView.addSubview(deleteImage)
        
        locationView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        locationView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        locationView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        locationView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        
        backgroundImage.leadingAnchor.constraint(equalTo: locationView.leadingAnchor, constant: 10).isActive = true
        backgroundImage.trailingAnchor.constraint(equalTo: locationView.trailingAnchor, constant: -20).isActive = true
        backgroundImage.topAnchor.constraint(equalTo: locationView.topAnchor, constant: 10).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: locationView.bottomAnchor, constant: -10).isActive = true
        backgroundImage.widthAnchor.constraint(equalTo: locationView.widthAnchor, constant: -30).isActive = true
        
        temperatureLabel.leadingAnchor.constraint(equalTo: locationView.leadingAnchor, constant: 16).isActive = true
        temperatureLabel.topAnchor.constraint(equalTo: locationView.topAnchor, constant: 16).isActive = true

        cityLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 4).isActive = true
        cityLabel.leadingAnchor.constraint(equalTo: locationView.leadingAnchor,constant: 16).isActive = true
        
        countryLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 4).isActive = true
        countryLabel.leadingAnchor.constraint(equalTo: locationView.leadingAnchor,constant: 16).isActive = true
        
        humidityIcon.bottomAnchor.constraint(equalTo: locationView.bottomAnchor,constant: -20).isActive = true
        humidityIcon.leadingAnchor.constraint(equalTo: locationView.leadingAnchor,constant: 16).isActive = true
        humidityIcon.widthAnchor.constraint(equalToConstant: 16).isActive = true
        humidityIcon.heightAnchor.constraint(equalToConstant: 16).isActive = true

        humidityLabel.bottomAnchor.constraint(equalTo: locationView.bottomAnchor,constant: -21).isActive = true
        humidityLabel.leadingAnchor.constraint(equalTo: humidityIcon.trailingAnchor,constant: 6).isActive = true
        
        windLabel.bottomAnchor.constraint(equalTo: locationView.bottomAnchor,constant: -21).isActive = true
        windLabel.trailingAnchor.constraint(equalTo: locationView.trailingAnchor,constant: -12).isActive = true
        
        windIcon.bottomAnchor.constraint(equalTo: locationView.bottomAnchor,constant: -20).isActive = true
        windIcon.trailingAnchor.constraint(equalTo: windLabel.leadingAnchor,constant: -5).isActive = true
        windIcon.widthAnchor.constraint(equalToConstant: 16).isActive = true
        windIcon.heightAnchor.constraint(equalToConstant: 16).isActive = true

        weatherIcon.topAnchor.constraint(equalTo: locationView.topAnchor).isActive = true
        weatherIcon.trailingAnchor.constraint(equalTo: locationView.trailingAnchor, constant: -5).isActive = true
        weatherIcon.widthAnchor.constraint(equalToConstant: 90).isActive = true
        weatherIcon.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        deleteImage.topAnchor.constraint(equalTo: locationView.topAnchor, constant: -5).isActive = true
        deleteImage.trailingAnchor.constraint(equalTo: locationView.trailingAnchor, constant: 5).isActive = true
        deleteImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        deleteImage.heightAnchor.constraint(equalToConstant: 30).isActive = true

    }
    
    private func styleView() {

        locationView.backgroundColor = .white.withAlphaComponent(0.2)
        locationView.layer.borderColor = UIColor.white.cgColor

        backgroundImage.alpha = 0.2
        
        temperatureLabel.textColor = .white
        
        cityLabel.textColor = .white
        
        countryLabel.textColor = .white.withAlphaComponent(0.7)
        
        humidityLabel.textColor = .white
        
        windLabel.textColor = .white
        
        deleteImage.isHidden = true
        
        

    }
    
}
