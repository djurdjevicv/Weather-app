//
//  DayWeatherView.swift
//  Weather app
//
//  Created by praksa on 17.11.22..
//

import UIKit

class DayWeatherView: UIView {

    // MARK: - UIProperties
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var weatherIcon: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var windView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var windIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "windIcon")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.accessibilityIdentifier = "text_windSpeed"
        return view
    }()
    
    lazy var windLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(14)
        return label
    }()
    
        
    // MARK: - Init

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
    
    
    func setupView() {
        
        addSubview(timeLabel)
        addSubview(temperatureLabel)
        addSubview(weatherIcon)
        addSubview(windView)
        windView.addArrangedSubview(windIcon)
        windView.addArrangedSubview(windLabel)
                
        timeLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        temperatureLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        temperatureLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 4).isActive = true
        
        weatherIcon.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        weatherIcon.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 5).isActive = true
        weatherIcon.widthAnchor.constraint(equalToConstant: 40).isActive = true
        weatherIcon.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        windView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        windView.topAnchor.constraint(equalTo: weatherIcon.bottomAnchor, constant: 11).isActive = true
        
        windIcon.heightAnchor.constraint(equalToConstant: 15).isActive = true
        windIcon.widthAnchor.constraint(equalToConstant: 15).isActive = true
        
        widthAnchor.constraint(equalToConstant: 100).isActive = true
        
    }
    
    func styleView() {
        timeLabel.textColor = .white
        temperatureLabel.textColor = .white
        windLabel.textColor = .white
                
    }

}
