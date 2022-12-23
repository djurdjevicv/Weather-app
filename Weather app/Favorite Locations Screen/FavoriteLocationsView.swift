//
//  FavoriteLocationsView.swift
//  Weather app
//
//  Created by praksa on 18.11.22..
//

import UIKit

class FavoriteLocationsView: UIView {

    lazy var favoriteLocationsCollectionView: FavoriteLocationsCollectionView = {
        let view = FavoriteLocationsCollectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indictor = UIActivityIndicatorView()
        indictor.translatesAutoresizingMaskIntoConstraints = false
        indictor.color = .white
        return indictor
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
        addSubview(favoriteLocationsCollectionView)
        addSubview(activityIndicator)

        favoriteLocationsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        favoriteLocationsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        favoriteLocationsCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        favoriteLocationsCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func styleView() {
        activityIndicator.transform = CGAffineTransform(scaleX: 2, y: 2)
    }

}
