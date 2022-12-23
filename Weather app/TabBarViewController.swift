//
//  ViewController.swift
//  Weather app
//
//  Created by praksa on 7.11.22..
//

import UIKit
import CoreLocation
import Resolver

class TabBarViewController: UITabBarController {

    @Injected var databaseService: DatabaseService
    
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .white
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()

        setUp()
    }
    
    let navigationHomeController = UINavigationController(rootViewController: HomeScreenViewController())
    let navigationSearchController = UINavigationController(rootViewController: SearchViewController())
    let navigationFavoritesController = UINavigationController(rootViewController: FavoritesViewController())
    let navigationSettingsController = UINavigationController(rootViewController: SettingsViewController())
    
    private func setUp() {
        navigationHomeController.navigationBar.topItem?.title = "Home"
        navigationSearchController.navigationBar.topItem?.title = "Search"
        navigationFavoritesController.navigationBar.topItem?.title = "Favorite locations"
        navigationSettingsController.navigationBar.topItem?.title = "Settings"

        navigationHomeController.tabBarItem.image = UIImage(systemName: "house")
        navigationSearchController.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        navigationFavoritesController.tabBarItem.image = UIImage(systemName: "heart")
        navigationSettingsController.tabBarItem.image = UIImage(systemName: "gearshape")
                
        navigationHomeController.navigationBar.styleNavigationBar()
        navigationSettingsController.navigationBar.styleNavigationBar()
        navigationSearchController.navigationBar.styleNavigationBar()
        navigationFavoritesController.navigationBar.styleNavigationBar()
        
        setViewControllers([navigationHomeController, navigationSearchController, navigationFavoritesController, navigationSettingsController], animated: false)
    }
    
}

extension TabBarViewController : CLLocationManagerDelegate {
    
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        if let location = locations.first {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            if let homeNavigationController = viewControllers?[0] as? UINavigationController, let homeScreenViewController =  homeNavigationController.viewControllers[0] as? HomeScreenViewController {
                
                homeScreenViewController.locationIsAvailable()
            }
            
            UserDefaults.currentLocation = Coord(lon: longitude, lat: latitude)
            
            if UserDefaults.selectedFavoriteLocation == nil {
                if let current = UserDefaults.currentLocation {
                    UserDefaults.selectedFavoriteLocation = current
                }
            }
            
            navigationHomeController.children.first!.viewWillAppear(true)
        }
    }
        
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            if UserDefaults.unitSystem == nil {
                UserDefaults.unitSystem = UnitSystem.celsius.rawValue
            }
            navigationHomeController.viewWillAppear(true)
        } else {
            UserDefaults.currentLocation = nil
            if UserDefaults.favoriteLocations == nil {
                UserDefaults.selectedFavoriteLocation = nil
            }
            
            if UserDefaults.unitSystem == nil {
                UserDefaults.unitSystem = UnitSystem.celsius.rawValue
            }
        }
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print("error:: \(error.localizedDescription)")
    }
}

