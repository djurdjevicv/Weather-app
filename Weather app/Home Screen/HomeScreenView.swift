//
//  CurrentWeatherView.swift
//  Weather app
//
//  Created by praksa on 9.11.22..
//

import UIKit

class HomeScreenView: UIView {
    
    // MARK: - UIProperties
    
    lazy var scrollView: UIScrollView = {
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
    
    private lazy var currentWeatherView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var cityLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = view.font.withSize(16)
        view.accessibilityIdentifier = "text_location"
        return view
    }()
    
    lazy var turnOnLocationButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.accessibilityIdentifier = "card_turnOnLocation"
        return view
    }()
    
    lazy var turnOnLocationLabel: UILabel = {
        let view = UILabel()
        view.text = "Turn on location"
        view.textAlignment = NSTextAlignment.center
        view.font = view.font.withSize(12)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var dot: UIView = {
        var view = UIView()
        view.layer.cornerRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var dateLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.font = view.font.withSize(14)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.accessibilityIdentifier = "text_date"
        return view
    }()
    
    private lazy var tempView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var degreesLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = view.font.withSize(96)
        view.accessibilityIdentifier = "text_currentTemperature"
        return view
    }()
    
    lazy var unitsLabel: UILabel = {
        let view = UILabel()
        view.font = view.font.withSize(24)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var cloudyLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = NSTextAlignment.center
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = view.font.withSize(20)
        view.accessibilityIdentifier = "layout_weatherDetails"
        return view
    }()
    
    private lazy var weatherDetailsView: UIStackView = {
        let view = UIStackView()
        view.distribution = .equalCentering
        view.axis = .horizontal
        view.alignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var humidityView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var windView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var airQualityView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var humidityIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "humidityIcon")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var humidityLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = view.font.withSize(16)
        view.textAlignment = .center
        view.accessibilityIdentifier = "text_humidity"
        view.sizeToFit()
        return view
    }()
    
    lazy var airQualityIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "airQualityIcon")
        view.accessibilityIdentifier = "image_airQuality"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var airQualityLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = view.font.withSize(16)
        view.text = "AQI 25"
        view.sizeToFit()
        view.textAlignment = .center
        view.accessibilityIdentifier = "text_airQuality"
        return view
    }()
    
    private lazy var windIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "windIcon")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.accessibilityIdentifier = "text_windSpeed"
        return view
    }()
    
    lazy var windLabel: UILabel = {
        let view = UILabel()
        sizeToFit()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = view.font.withSize(16)
        view.textAlignment = .center
        return view
    }()
    
    lazy var weatherDetailsCollectionView: WeatherDetailView = {
        let view = WeatherDetailView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var fiveDaysTableView: FiveDaysWeatherTableView = {
        let view = FiveDaysWeatherTableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var activityIndicator: UIActivityIndicatorView = {
        let indictor = UIActivityIndicatorView()
        indictor.translatesAutoresizingMaskIntoConstraints = false
        indictor.color = .white
        return indictor
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
        addSubview(cityLabel)
        addSubview(turnOnLocationButton)
        addSubview(turnOnLocationLabel)
        addSubview(dot)
        addSubview(dateLabel)
        
        addSubview(scrollView)
        addSubview(activityIndicator)
        
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(currentWeatherView)
        stackView.addArrangedSubview(fiveDaysTableView)
        stackView.addArrangedSubview(weatherDetailsCollectionView)
        
        currentWeatherView.addSubview(cityLabel)
        currentWeatherView.addSubview(turnOnLocationButton)
        currentWeatherView.addSubview(turnOnLocationLabel)
        currentWeatherView.addSubview(dot)
        currentWeatherView.addSubview(dateLabel)
        
        currentWeatherView.addSubview(tempView)
        tempView.addSubview(degreesLabel)
        tempView.addSubview(unitsLabel)
        
        currentWeatherView.addSubview(cloudyLabel)
        currentWeatherView.addSubview(weatherDetailsView)
        
        humidityView.addSubview(humidityIcon)
        humidityView.addSubview(humidityLabel)
        
        airQualityView.addSubview(airQualityIcon)
        airQualityView.addSubview(airQualityLabel)
        
        windView.addSubview(windIcon)
        windView.addSubview(windLabel)
        
        weatherDetailsView.addArrangedSubview(humidityView)
        weatherDetailsView.addArrangedSubview(airQualityView)
        weatherDetailsView.addArrangedSubview(windView)
        
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        cityLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        cityLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        cityLabel.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        
        turnOnLocationButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        turnOnLocationButton.heightAnchor.constraint(equalToConstant: 28).isActive = true
        turnOnLocationButton.widthAnchor.constraint(equalToConstant: 154).isActive = true
        turnOnLocationButton.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 13).isActive = true
        
        turnOnLocationLabel.centerXAnchor.constraint(equalTo: turnOnLocationButton.centerXAnchor).isActive = true
        turnOnLocationLabel.centerYAnchor.constraint(equalTo: turnOnLocationButton.centerYAnchor).isActive = true
        turnOnLocationLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        dot.centerYAnchor.constraint(equalTo: turnOnLocationButton.centerYAnchor).isActive = true
        dot.heightAnchor.constraint(equalToConstant: 8).isActive = true
        dot.widthAnchor.constraint(equalToConstant: 8).isActive = true
        dot.leadingAnchor.constraint(equalTo: turnOnLocationLabel.trailingAnchor, constant: 5).isActive = true
        
        dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 17).isActive = true
        dateLabel.topAnchor.constraint(equalTo: turnOnLocationButton.bottomAnchor, constant: 20).isActive = true
        
        tempView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tempView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        tempView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor,constant: 16).isActive = true
        tempView.heightAnchor.constraint(equalToConstant: 119).isActive = true
        
        degreesLabel.centerXAnchor.constraint(equalTo: tempView.centerXAnchor).isActive = true
        
        unitsLabel.leadingAnchor.constraint(equalTo: degreesLabel.trailingAnchor, constant: 2).isActive = true
        unitsLabel.topAnchor.constraint(equalTo:  tempView.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        
        cloudyLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        cloudyLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        cloudyLabel.topAnchor.constraint(equalTo: tempView.bottomAnchor, constant: 8).isActive = true
        
        weatherDetailsView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        weatherDetailsView.topAnchor.constraint(equalTo: cloudyLabel.bottomAnchor, constant: 36).isActive = true
        weatherDetailsView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40).isActive = true
        weatherDetailsView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40).isActive = true

        humidityIcon.heightAnchor.constraint(equalToConstant: 24).isActive = true
        humidityIcon.widthAnchor.constraint(equalToConstant: 24).isActive = true
        humidityIcon.leadingAnchor.constraint(equalTo: humidityView.leadingAnchor).isActive = true
        humidityIcon.topAnchor.constraint(equalTo: humidityView.topAnchor).isActive = true

        humidityLabel.leadingAnchor.constraint(equalTo: humidityIcon.trailingAnchor, constant: 5).isActive = true
        humidityLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        humidityLabel.trailingAnchor.constraint(equalTo: humidityView.trailingAnchor).isActive = true
        humidityLabel.topAnchor.constraint(equalTo: humidityView.topAnchor).isActive = true

        airQualityIcon.heightAnchor.constraint(equalToConstant: 24).isActive = true
        airQualityIcon.widthAnchor.constraint(equalToConstant: 24).isActive = true

        airQualityIcon.topAnchor.constraint(equalTo: airQualityView.topAnchor).isActive = true
        airQualityIcon.leadingAnchor.constraint(equalTo: airQualityView.leadingAnchor).isActive = true

        airQualityLabel.leadingAnchor.constraint(equalTo: airQualityIcon.trailingAnchor, constant: 5).isActive = true
        airQualityLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        airQualityLabel.trailingAnchor.constraint(equalTo: airQualityView.trailingAnchor).isActive = true
        airQualityLabel.topAnchor.constraint(equalTo: airQualityView.topAnchor).isActive = true

        windIcon.heightAnchor.constraint(equalToConstant: 24).isActive = true
        windIcon.widthAnchor.constraint(equalToConstant: 24).isActive = true
        windIcon.leadingAnchor.constraint(equalTo: windView.leadingAnchor).isActive = true
        windIcon.topAnchor.constraint(equalTo: windView.topAnchor).isActive = true
        
        windLabel.leadingAnchor.constraint(equalTo: windIcon.trailingAnchor, constant: 5).isActive = true
        windLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        windLabel.trailingAnchor.constraint(equalTo: windView.trailingAnchor).isActive = true
        windLabel.topAnchor.constraint(equalTo: windView.topAnchor).isActive = true
        
        fiveDaysTableView.topAnchor.constraint(equalTo: weatherDetailsView.bottomAnchor, constant: 40).isActive = true
        fiveDaysTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        fiveDaysTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        fiveDaysTableView.heightAnchor.constraint(equalToConstant: 300).isActive = true
                
        weatherDetailsCollectionView.topAnchor.constraint(equalTo: fiveDaysTableView.bottomAnchor, constant: 20).isActive = true
        weatherDetailsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        weatherDetailsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        weatherDetailsCollectionView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
    }
    
    func styleView() {
        cityLabel.textColor = .white
        
        turnOnLocationButton.alpha = 0.3
        turnOnLocationButton.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        turnOnLocationButton.layer.cornerRadius = 16
        
        turnOnLocationLabel.textColor = .white
        
        dateLabel.textColor = .white
        
        dot.backgroundColor = .yellow
        
        degreesLabel.textColor = .white
        
        unitsLabel.textColor = .white
        
        cloudyLabel.textColor = .white
        
        humidityLabel.textColor = .white
        
        windLabel.textColor = .white
        
        airQualityLabel.textColor = .white
        
        activityIndicator.transform = CGAffineTransform(scaleX: 2, y: 2)
    }
    
}
