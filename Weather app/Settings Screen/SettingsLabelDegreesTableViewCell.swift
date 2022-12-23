//
//  SettingsLabelDegreesTableViewCell.swift
//  Weather app
//
//  Created by praksa on 16.11.22..
//

import UIKit

class SettingsLabelDegreesTableViewCell: SettingsTableViewCell {
    
    private let labelDegrees: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let icon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "chevronRight")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
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
        titleLabel.text = nil
        labelDegrees.text = nil
    }
    
    public func configure(with model: SettingsDegreesLabelOption){
        titleLabel.text = model.title
        labelDegrees.text = model.degrees
    }
    
    override func setupView(){
        super.setupView()
        contentView.addSubview(labelDegrees)
        contentView.addSubview(icon)
        contentView.clipsToBounds = true
                
        labelDegrees.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        labelDegrees.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40).isActive = true
        
        icon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        icon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true        
    }
    
    override func styleView(){
        super.styleView()
        labelDegrees.textColor = .white
    }

}
