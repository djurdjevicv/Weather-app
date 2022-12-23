//
//  CurrentWeather.swift
//  Weather app
//
//  Created by praksa on 8.11.22..
//

import Foundation

struct CurrentWeather: Codable {
    
    var coord: Coord?
    var weather: [Weather]
    var base: String?
    var main: Main
    var visibility: Int
    var wind: Wind
    var clouds: Clouds
    var dt: Int
    var sys: Sys
    var timezone: Int?
    var id: Int?
    var name: String? 
    var cod: Int?
    var pop: Double?
    var dt_txt: String? 
}
