//
//  Main.swift
//  Weather app
//
//  Created by praksa on 8.11.22..
//

import Foundation

struct Main: Codable {
    var temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
    var pressure: Int
    var sea_level: Int?
    var grnd_level: Int?
    var humidity: Int
    var temp_kf: Double? 
}
