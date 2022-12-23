//
//  FiveDaysWeatherTableView.swift
//  Weather app
//
//  Created by praksa on 15.11.22..
//

import UIKit

class FiveDaysWeatherTableView: UIView {

    lazy var weatherTableView:  UITableView = {
        let tableView = UITableView()
        tableView.register(FiveDaysWeatherTableViewCell.self, forCellReuseIdentifier: Constants.fiveDaysWeatherTableViewCell)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()

    init() {
        super.init(frame: .zero)
        styleView()
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func styleView() {
        weatherTableView.backgroundColor = .clear
    }

    private func setupView() {
        addSubview(weatherTableView)
        
        translatesAutoresizingMaskIntoConstraints = false
                
        weatherTableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        weatherTableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        weatherTableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        weatherTableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        heightAnchor.constraint(equalToConstant: 220).isActive = true
        
    }
    
}
