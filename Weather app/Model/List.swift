//
//  List.swift
//  Weather app
//
//  Created by praksa on 14.11.22..
//

import Foundation

struct List: Codable {
    var dt: Int?
    var main: AirQualityMain
    var components: Components
}

