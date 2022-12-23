//
//  File.swift
//  Weather app
//
//  Created by praksa on 18.11.22..
//

import Foundation

struct Location: Codable {
    let name: String
    let lat: Double
    let lon: Double
    let country: String
    let localNames: [String: String]?
}
