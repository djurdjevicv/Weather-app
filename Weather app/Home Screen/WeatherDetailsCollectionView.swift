//
//  WeatherDetailsCollectionView.swift
//  Weather app
//
//  Created by praksa on 9.11.22..
//

import UIKit

class WeatherDetailView: UIView {
    
    lazy var weatherCollectionView:  UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 30, bottom: 20, right: 30)
        let screenSize = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: screenSize/2-55 , height: 80 )
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(WeatherDetailsCollectionViewCell.self, forCellWithReuseIdentifier: Constants.weatherDetailCell)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        weatherCollectionView.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        weatherCollectionView.layer.cornerRadius = 24
        self.backgroundColor = .clear
    }
    
    private func setupView() {
        addSubview(weatherCollectionView)
        
        weatherCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        weatherCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        weatherCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        weatherCollectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
    }

}
