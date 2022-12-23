//
//  SettingsTableViewCell.swift
//  Weather app
//
//  Created by praksa on 17.11.22..
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

     let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let separatorView: UIView = {
        let view = UIView()
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
        
    func setupView(){
        contentView.addSubview(separatorView)
        contentView.addSubview(titleLabel)
        contentView.clipsToBounds = true
        
        titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
                
        separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
    
    func styleView(){
        backgroundColor = .clear

        separatorView.backgroundColor = .white.withAlphaComponent(0.5)
        titleLabel.textColor = .white
    }

}
