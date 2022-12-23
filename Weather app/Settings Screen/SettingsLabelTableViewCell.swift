//
//  SettingsLabelTableViewCell.swift
//  Weather app
//
//  Created by praksa on 16.11.22..
//

import UIKit

class SettingsLabelTableViewCell: SettingsTableViewCell {
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
    
    public func configure(with model: SettingsOption){
        titleLabel.text = model.title
    }

    
}
