//
//  DetailsView.swift
//  Weather app
//
//  Created by praksa on 17.11.22..
//

import UIKit

class DetailsView: UIView {

    // MARK: - UIProperties
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    
    private lazy var locationView: UIView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 30
        return view
    }()
    
    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(20)
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
        label.font = label.font.withSize(14)
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
        label.font = label.font.withSize(14)
        return label
    }()
    
    lazy var weatherIcon: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var weatherDetailsCollectionView: WeatherDetailView = {
        let view = WeatherDetailView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var addLocationButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 22
        button.setTitle("Add location", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var dayWeatherView: UIView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var scrollViewDayWeather: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    lazy var stackViewDayWeather: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
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
        setBackgroundGradient()
    }
    
    
    func setupView() {
        
        addSubview(scrollView)
        
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(locationView)
        stackView.addArrangedSubview(dayWeatherView)
        stackView.addArrangedSubview(weatherDetailsCollectionView)
        stackView.addArrangedSubview(addLocationButton)
        
        dayWeatherView.addSubview(scrollViewDayWeather)
        scrollViewDayWeather.addSubview(stackViewDayWeather)
        
        locationView.addSubview(temperatureLabel)
        locationView.addSubview(cityLabel)
        locationView.addSubview(countryLabel)
        locationView.addSubview(humidityIcon)
        locationView.addSubview(humidityLabel)
        locationView.addSubview(windIcon)
        locationView.addSubview(windLabel)
        locationView.addSubview(weatherIcon)

        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        locationView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        locationView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25).isActive = true
        locationView.leadingAnchor.constraint(equalTo: trailingAnchor, constant: 25).isActive = true
        locationView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        
        temperatureLabel.topAnchor.constraint(equalTo: locationView.topAnchor, constant: 22).isActive = true
        temperatureLabel.leadingAnchor.constraint(equalTo: locationView.leadingAnchor, constant: 22).isActive = true
        
        cityLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 4).isActive = true
        cityLabel.leadingAnchor.constraint(equalTo: locationView.leadingAnchor, constant: 22).isActive = true
        
        countryLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 4).isActive = true
        countryLabel.leadingAnchor.constraint(equalTo: locationView.leadingAnchor, constant: 22).isActive = true

        humidityIcon.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 20).isActive = true
        humidityIcon.leadingAnchor.constraint(equalTo: locationView.leadingAnchor, constant: 22).isActive = true
        humidityIcon.widthAnchor.constraint(equalToConstant: 19).isActive = true
        humidityIcon.heightAnchor.constraint(equalToConstant: 16).isActive = true

        humidityLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 20).isActive = true
        humidityLabel.leadingAnchor.constraint(equalTo: humidityIcon.trailingAnchor, constant: 7).isActive = true
        
        windIcon.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 20).isActive = true
        windIcon.leadingAnchor.constraint(equalTo: humidityLabel.trailingAnchor, constant: 24).isActive = true
        windIcon.widthAnchor.constraint(equalToConstant: 19).isActive = true
        windIcon.heightAnchor.constraint(equalToConstant: 16).isActive = true

        windLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 20).isActive = true
        windLabel.leadingAnchor.constraint(equalTo: windIcon.trailingAnchor, constant: 7).isActive = true
        
        weatherIcon.trailingAnchor.constraint(equalTo: locationView.trailingAnchor, constant: -40).isActive = true
        weatherIcon.topAnchor.constraint(equalTo: locationView.topAnchor, constant: 45).isActive = true
        weatherIcon.widthAnchor.constraint(equalToConstant: 90).isActive = true
        weatherIcon.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        weatherDetailsCollectionView.topAnchor.constraint(equalTo: dayWeatherView.bottomAnchor, constant: 20).isActive = true
        weatherDetailsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        weatherDetailsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        weatherDetailsCollectionView.heightAnchor.constraint(equalToConstant: 200).isActive = true

        addLocationButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        addLocationButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 47).isActive = true
        addLocationButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -47).isActive = true
        addLocationButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        dayWeatherView.topAnchor.constraint(equalTo: locationView.bottomAnchor, constant: 10).isActive = true
        dayWeatherView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22).isActive = true
        dayWeatherView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22).isActive = true
        dayWeatherView.heightAnchor.constraint(equalToConstant: 110).isActive = true

        scrollViewDayWeather.leadingAnchor.constraint(equalTo: dayWeatherView.leadingAnchor).isActive = true
        scrollViewDayWeather.trailingAnchor.constraint(equalTo: dayWeatherView.trailingAnchor).isActive = true
        scrollViewDayWeather.topAnchor.constraint(equalTo: dayWeatherView.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollViewDayWeather.bottomAnchor.constraint(equalTo: dayWeatherView.bottomAnchor).isActive = true
        
        stackViewDayWeather.leadingAnchor.constraint(equalTo: scrollViewDayWeather.leadingAnchor).isActive = true
        stackViewDayWeather.trailingAnchor.constraint(equalTo: scrollViewDayWeather.trailingAnchor).isActive = true
        stackViewDayWeather.topAnchor.constraint(equalTo: scrollViewDayWeather.topAnchor).isActive = true
        stackViewDayWeather.bottomAnchor.constraint(equalTo: scrollViewDayWeather.bottomAnchor).isActive = true
    }
    
    func styleView() {

        locationView.backgroundColor = .white.withAlphaComponent(0.2)
        
        temperatureLabel.textColor = .white
        
        cityLabel.textColor = .white
        
        countryLabel.textColor = .white
        
        humidityLabel.textColor = .white
        
        windLabel.textColor = .white
        
        addLocationButton.backgroundColor = .white
        
        addLocationButton.setTitleColor(UIColor(red: 71/255, green: 106/255, blue: 118/255, alpha: 1), for: .normal)
    }
    
}
