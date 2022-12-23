//
//  FiveDaysWeather.swift
//  Weather app
//
//  Created by praksa on 10.11.22..
//

import Foundation

struct FiveDaysWeather: Codable {
    
    var cod: String
    var message: Int
    var cnt: Int
    var list: [CurrentWeather]
    var city: City
    
}
