//
//  OneDayWeather.swift
//  Weather app
//
//  Created by praksa on 14.11.22..
//

import Foundation

struct OneDayWeather {
    
    var minTemp: Double
    var maxTemp: Double
    var dayOfTheWeek: String
    var weatherDescription: String
    var weatherIcon: String
    
    init(minTemp: Double, maxTemp: Double, dayOfTheWeek: String, weatherDescription: String, weatherIcon: String) {
        self.minTemp = minTemp
        self.maxTemp = maxTemp
        self.dayOfTheWeek = dayOfTheWeek
        self.weatherDescription = weatherDescription
        self.weatherIcon = weatherIcon
    }
    
}

