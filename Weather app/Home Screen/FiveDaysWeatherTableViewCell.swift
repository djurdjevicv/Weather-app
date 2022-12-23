//
//  FiveDaysWeatherTableViewCell.swift
//  Weather app
//
//  Created by praksa on 15.11.22..
//

import UIKit

class FiveDaysWeatherTableViewCell: UITableViewCell {

    lazy var icon: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var dayOfWeek: UILabel = {
        var label = UILabel()
        label.font = label.font.withSize(16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dot: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 2
        return view
    }()
    
    lazy var weatherDescription: UILabel = {
        var label = UILabel()
        label.font = label.font.withSize(16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stackView: UIStackView = {
        var view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        return view
    }()
    
    lazy var maxTemp: UILabel = {
        var label = UILabel()
        label.font = label.font.withSize(16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var slash: UILabel = {
        var label = UILabel()
        label.font = label.font.withSize(16)
        label.text = " / "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var minTemp: UILabel = {
        var label = UILabel()
        label.font = label.font.withSize(16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        styleView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        addSubview(icon)
        addSubview(dayOfWeek)
        addSubview(dot)
        addSubview(weatherDescription)
        addSubview(stackView)
        
        stackView.addArrangedSubview(maxTemp)
        stackView.addArrangedSubview(slash)
        stackView.addArrangedSubview(minTemp)

        icon.topAnchor.constraint(equalTo: topAnchor).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 40).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        dayOfWeek.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        dayOfWeek.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 10).isActive = true
        dayOfWeek.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        dot.topAnchor.constraint(equalTo: topAnchor, constant: 18).isActive = true
        dot.leadingAnchor.constraint(equalTo: dayOfWeek.trailingAnchor, constant: 5).isActive = true
        dot.heightAnchor.constraint(equalToConstant: 4).isActive = true
        dot.widthAnchor.constraint(equalToConstant: 4).isActive = true
    
        weatherDescription.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        weatherDescription.leadingAnchor.constraint(equalTo: dot.trailingAnchor, constant: 5).isActive = true
        weatherDescription.heightAnchor.constraint(equalToConstant: 20).isActive = true

        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
    }
    
    private func styleView() {
        
        dayOfWeek.textColor = .white
        
        weatherDescription.textColor = .white
        
        dot.backgroundColor = .white
        
        minTemp.textColor = .white
        slash.textColor = .white
        maxTemp.textColor = .white
    }

}
