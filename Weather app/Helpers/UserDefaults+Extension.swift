//
//  UserDefaults+Extension.swift
//  Weather app
//
//  Created by praksa on 23.11.22..
//

import Foundation

extension UserDefaults {
    enum Key {
        static let currentLocation = "current_location"
        static let favoriteLocations = "favorite_locations"
        static let selectedFavoriteLocation = "selected_favorite_location"
        static let unitSystem = "unit_system"
    }

    static var currentLocation: Coord? {
        get {
            guard let coordData = standard.data(forKey: Key.currentLocation),
                  let coord = try? JSONDecoder().decode(Coord.self, from: coordData) else {
                return nil
            }
            return coord
        }
        set {
            let coordData = try? JSONEncoder().encode(newValue)
            standard.set(coordData, forKey: Key.currentLocation)
        }
    }
    
    static var favoriteLocations: [Coord]? {
        get {
            guard let coordData = standard.data(forKey: Key.favoriteLocations),
                  let coord = try? JSONDecoder().decode([Coord].self, from: coordData) else {
                return nil
            }
            return coord
        }
        set {
            let coordData = try? JSONEncoder().encode(newValue)
            standard.set(coordData, forKey: Key.favoriteLocations)
        }
    }
    
    static var selectedFavoriteLocation: Coord? {
        get {
            guard let coordData = standard.data(forKey: Key.selectedFavoriteLocation),
                  let coord = try? JSONDecoder().decode(Coord.self, from: coordData) else {
                return nil
            }
            return coord
        }
        set {
            let coordData = try? JSONEncoder().encode(newValue)
            standard.set(coordData, forKey: Key.selectedFavoriteLocation)
        }
    }
    
    static var unitSystem: String? {
        get {
            guard let unitSystemData = standard.data(forKey: Key.unitSystem),
                  let unitSystem = try? JSONDecoder().decode(String.self, from: unitSystemData) else {
                return nil
            }
            return unitSystem
        }
        set {
            let unitSystemData = try? JSONEncoder().encode(newValue)
            standard.set(unitSystemData, forKey: Key.unitSystem)
        }
    }
    
    
}

