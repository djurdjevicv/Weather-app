//
//  Resolver.swift
//  Weather app
//
//  Created by praksa on 7.11.22..
//

import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {

        register { WeatherNetworkingService() }
        register { DatabaseService() }
    }
}
