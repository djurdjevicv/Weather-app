//
//  WeatherDetailsCollectionViewCell.swift
//  Weather app
//
//  Created by praksa on 9.11.22..
//

import UIKit

class WeatherDetailsCollectionViewCell: UICollectionViewCell {
    
    lazy var detailName: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var detailValue: UILabel = {
        let view = UILabel()
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
        addSubview(detailName)
        addSubview(detailValue)

        detailName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        detailName.heightAnchor.constraint(equalToConstant: 15).isActive = true
        detailName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10).isActive = true
        detailName.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
                
        detailValue.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        detailValue.heightAnchor.constraint(equalToConstant: 25).isActive = true
        detailValue.topAnchor.constraint(equalTo: detailName.bottomAnchor, constant: 5).isActive = true
    }
    
    private func styleView() {
        detailName.textColor = UIColor.white.withAlphaComponent(0.6)
        detailName.minimumScaleFactor = 0.2
        
        detailValue.textColor = .white
    }
}
