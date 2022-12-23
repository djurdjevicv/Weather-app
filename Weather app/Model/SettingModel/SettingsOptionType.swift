//
//  SettingsOptionType.swift
//  Weather app
//
//  Created by praksa on 17.11.22..
//

import Foundation

enum SettingsOptionType {
    case labelCell(model: SettingsOption)
    case switchCell(model: SettingsSwitchOption)
    case degreesCell(model: SettingsDegreesLabelOption)
}
