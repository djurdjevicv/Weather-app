//
//  ResultsTableViewCell.swift
//  Weather app
//
//  Created by praksa on 17.11.22..
//

import UIKit

class ResultsTableViewCell: UITableViewCell {
    
    lazy var cityLabel: UILabel = {
        var view = UILabel()
        //view.text = "Rio de Janeiro"
        view.font = view.font.withSize(14)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var stateLabel: UILabel = {
        var view = UILabel()
        //view.text = "BRA"
        view.font = view.font.withSize(18)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var cityDetailView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var cityDetailLabel: UILabel = {
        var view = UILabel()
        view.text = "See more details"
        view.font = view.font.withSize(12)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var cityDetailLabelIcon: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(named: "cityDetailLabelIcon")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        styleView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stateLabel.text = nil
        cityLabel.text = nil
    }
    
        
    private func setupView() {
                
        addSubview(cityLabel)
        addSubview(stateLabel)
        addSubview(cityDetailLabel)
        addSubview(cityDetailView)
        cityDetailView.addSubview(cityDetailLabel)
        cityDetailView.addSubview(cityDetailLabelIcon)
        
        cityLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40).isActive = true
        cityLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        cityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        cityLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -200).isActive = true
        
        stateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        stateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 40).isActive = true
        stateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        stateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -260).isActive = true
        
        cityDetailView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        cityDetailView.topAnchor.constraint(equalTo: topAnchor, constant: 55).isActive = true
        cityDetailView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 200).isActive = true
        cityDetailView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true

        cityDetailLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        cityDetailLabel.topAnchor.constraint(equalTo: topAnchor, constant: 55).isActive = true
        cityDetailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 200).isActive = true
        cityDetailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40).isActive = true
        
        cityDetailLabelIcon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
        cityDetailLabelIcon.topAnchor.constraint(equalTo: topAnchor, constant: 59).isActive = true
        cityDetailLabelIcon.leadingAnchor.constraint(equalTo: cityDetailLabel.trailingAnchor, constant: 5).isActive = true
        cityDetailLabelIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -23).isActive = true
        }
    
    private func styleView() {
        self.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        self.layer.cornerRadius = 24
        
        cityLabel.textColor = .white
        
        stateLabel.textColor = UIColor.white.withAlphaComponent(0.7)

        cityDetailLabel.textColor = .white
        
    }

}
