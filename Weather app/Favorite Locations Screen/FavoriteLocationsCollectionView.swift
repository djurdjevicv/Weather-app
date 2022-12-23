//
//  FavoriteLocationsCollectionView.swift
//  Weather app
//
//  Created by praksa on 18.11.22..
//

import UIKit

class FavoriteLocationsCollectionView: UIView {

    lazy var favoriteLocationsCollectionView:  UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let screenSize = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: screenSize/2-20 , height: 160)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(FavoriteLocationCollectionViewCell.self, forCellWithReuseIdentifier: Constants.favoriteLocationCollectionViewCell)
        view.register(LocationOffCollectionViewCell.self, forCellWithReuseIdentifier: Constants.locationOffCollectionViewCell)
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constants.emptyCell)
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
        favoriteLocationsCollectionView.backgroundColor = .clear
    }
    
    private func setupView() {
        addSubview(favoriteLocationsCollectionView)
        
        favoriteLocationsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        favoriteLocationsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        favoriteLocationsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        favoriteLocationsCollectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
    }

}
