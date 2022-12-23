//
//  SettingsSwitchTableViewCell.swift
//  Weather app
//
//  Created by praksa on 16.11.22..
//

import UIKit

class SettingsSwitchTableViewCell: SettingsTableViewCell {
    
    public let mySwitch: UISwitch = {
        let mySwitch = UISwitch()
        mySwitch.onTintColor = .systemGreen
        mySwitch.translatesAutoresizingMaskIntoConstraints = false
        return mySwitch
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
        mySwitch.isOn = false
    }
    
    public func configure(with model: SettingsSwitchOption){
        titleLabel.text = model.title
        mySwitch.isOn = model.isOn
    }
    
    override func setupView(){
        super.setupView()
        contentView.addSubview(mySwitch)
        contentView.clipsToBounds = true
        accessoryType = .none
        
        mySwitch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        mySwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true

    }
    
    override func styleView(){
        super.styleView()
        titleLabel.textColor = .white
    }

}
