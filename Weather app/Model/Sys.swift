//
//  Sys.swift
//  Weather app
//
//  Created by praksa on 8.11.22..
//

import Foundation

struct Sys: Codable {
    var type: Int? 
    var id: Int?
    var country: String?
    var sunrise: Int?
    var sunset: Int?
    var pod: String?
}
