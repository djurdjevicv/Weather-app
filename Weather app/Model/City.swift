//
//  City.swift
//  Weather app
//
//  Created by praksa on 10.11.22..
//

import Foundation

struct City: Codable {
    var id: Int
    var name: String
    var coord: Coord
    var country: String
    var population: Int
    var timezone: Int
    var sunrise: Int
    var sunset: Int
}
