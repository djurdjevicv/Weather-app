//
//  FavoritesController.swift
//  Weather app
//
//  Created by praksa on 8.11.22..
//

import UIKit
import Resolver

class FavoritesViewController: UIViewController {

    @Injected var weatherNetworkingService: WeatherNetworkingService
    @Injected var databaseService: DatabaseService

    var iconShake = CABasicAnimation()
    var isEditEnabled = false
    
    private let favoritesView = FavoriteLocationsView()
    private let disabledInternet = InternetDisabledView()
    
    private var listFavoriteLocations: [CurrentWeather] = []
            
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.setBackgroundGradient()
        
        if !Reachability.isConnectedToNetwork() {
            view = disabledInternet
            navigationController?.setNavigationBarHidden(true, animated: animated)
            
            disabledInternet.actionTitle.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openSettings)))
        } else {
            view = favoritesView
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
     
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(editLocation))

        self.favoritesView.favoriteLocationsCollectionView.favoriteLocationsCollectionView.delegate = self
        self.favoritesView.favoriteLocationsCollectionView.favoriteLocationsCollectionView.dataSource = self
        
        iconShake = CABasicAnimation(keyPath: "transform.rotation.z")
        iconShake.fromValue = -0.1
        iconShake.toValue = 0.1
        iconShake.autoreverses = true
        iconShake.duration = 0.3
        iconShake.repeatCount = Float.greatestFiniteMagnitude
    }
    
    @objc private func openSettings() {
        guard let settingsUrl = URL(string: "App-Prefs:root=WIFI") else {
            return
        }

        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                print("Settings opened: \(success)")
            })
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.favoritesView.activityIndicator.startAnimating()
        self.favoritesView.favoriteLocationsCollectionView.alpha = 0
        listFavoriteLocations = []
        getCurrentLocation()
    }
    
    @objc func editLocation(sender: UIBarButtonItem) {
        isEditEnabled = !isEditEnabled
        favoritesView.favoriteLocationsCollectionView.favoriteLocationsCollectionView.reloadData()
    }
    
    private func getCurrentLocation(){
        if let currentLocationCoord = UserDefaults.currentLocation {
            weatherNetworkingService.getCurrentWeather(lat: currentLocationCoord.lat, lon: currentLocationCoord.lon) { result in
                switch result {
                case .success(let currentWeather):

                    self.listFavoriteLocations.insert(currentWeather, at: 0)
                    self.getFavoriteLocations()
                    DispatchQueue.main.async {
                        self.favoritesView.favoriteLocationsCollectionView.favoriteLocationsCollectionView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        } else {
            self.getGhostLocation()
            DispatchQueue.main.async {
                self.favoritesView.favoriteLocationsCollectionView.favoriteLocationsCollectionView.reloadData()
            }
        }
    }
    
    private func getFavoriteLocations() {
        if let favoriteLocations = UserDefaults.favoriteLocations {
            for coord in favoriteLocations {
                weatherNetworkingService.getCurrentWeather(lat: coord.lat, lon: coord.lon) { result in
                    switch result {
                    case .success(let currentWeather):

                        self.listFavoriteLocations.append(currentWeather)
                        
                        DispatchQueue.main.async {
                            self.favoritesView.favoriteLocationsCollectionView.favoriteLocationsCollectionView.reloadData()
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
    
    private func getGhostLocation(){
        weatherNetworkingService.getCurrentWeather(lat: 0.0, lon: 0.0) { result in
            switch result {
            case .success(let currentWeather):
                self.listFavoriteLocations.insert(currentWeather, at: 0)
                self.getFavoriteLocations()
                DispatchQueue.main.async {
                    self.favoritesView.favoriteLocationsCollectionView.favoriteLocationsCollectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension FavoritesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listFavoriteLocations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: Constants.favoriteLocationCollectionViewCell, for: indexPath) as? FavoriteLocationCollectionViewCell)!
        
        let cellEmpty = (collectionView.dequeueReusableCell(withReuseIdentifier: Constants.emptyCell, for: indexPath))
        
        let locationAvailable: Bool = (UserDefaults.currentLocation != nil)
        
        self.favoritesView.activityIndicator.stopAnimating()
        self.favoritesView.favoriteLocationsCollectionView.alpha = 1
        
        let oneLocation = listFavoriteLocations[indexPath.row]
        
        var isSelectedCell = false
        var isCurrentSelected = false
                
        if let selected = UserDefaults.selectedFavoriteLocation {
            if selected.lat == oneLocation.coord?.lat && selected.lon == oneLocation.coord?.lon {
                isSelectedCell = true
            }
        }
        
        if let selected = UserDefaults.selectedFavoriteLocation, let current = UserDefaults.currentLocation {
            if selected.lat == current.lat && selected.lon == current.lon {
                isCurrentSelected = true
            }
        }
        
        
        if indexPath.row == 0 {
            if locationAvailable == false {
                
                if let cell1 = (collectionView.dequeueReusableCell(withReuseIdentifier: Constants.locationOffCollectionViewCell, for: indexPath) as? LocationOffCollectionViewCell) {
                    
                    cell1.isUserInteractionEnabled = false
                    
                    return cell1
                }
            } else {
                if UserDefaults.unitSystem == UnitSystem.fahrenheit.rawValue {
                    cell.temperatureLabel.text = ("\(String(format: "%.0f", oneLocation.main.temp))°F")
                } else {
                    cell.temperatureLabel.text = ("\(String(format: "%.0f", oneLocation.main.temp))°C")
                }
                cell.cityLabel.text = oneLocation.name
                cell.countryLabel.text = oneLocation.sys.country
                
                cell.humidityLabel.text = "\(oneLocation.main.humidity)%"
                cell.windLabel.text = String(format: "%.2f", oneLocation.wind.speed) + "km/h"
                cell.weatherIcon.image = UIImage(named: oneLocation.weather[0].icon)
                
                cell.backgroundImage.isHidden = false
                cell.locationView.backgroundColor = .black.withAlphaComponent(0.2)
                cell.deleteImage.isHidden = true
                
                if isSelectedCell {
                    cell.locationView.layer.borderWidth = 5.0
                    cell.deleteImage.isHidden = true
                } else if isCurrentSelected {
                    cell.locationView.layer.borderWidth = 5.0
                    cell.deleteImage.isHidden = true
                }
                
                if isEditEnabled {
                    cell.layer.add(iconShake, forKey: "iconShakeAnimation")
                }
                return cell
            }
        } else if indexPath.row != 0 {
            if UserDefaults.unitSystem == UnitSystem.fahrenheit.rawValue {
                cell.temperatureLabel.text = ("\(String(format: "%.0f", oneLocation.main.temp))°F")
            } else {
                cell.temperatureLabel.text = ("\(String(format: "%.0f", oneLocation.main.temp))°C")
            }
            cell.cityLabel.text = oneLocation.name
            cell.countryLabel.text = oneLocation.sys.country
            
            cell.humidityLabel.text = "\(oneLocation.main.humidity)%"
            cell.windLabel.text = String(format: "%.2f", oneLocation.wind.speed) + "km/h"
            cell.weatherIcon.image = UIImage(named: oneLocation.weather[0].icon)
            
            cell.deleteImage.isHidden = !isEditEnabled
            cell.deleteImage.tag = indexPath.row
            cell.deleteImage.addTarget(self,action:#selector(removeFavoriteLocation), for: .touchUpInside)
            
            if isSelectedCell {
                cell.locationView.layer.borderWidth = 5.0
                cell.deleteImage.isHidden = true
            }
            
            if isEditEnabled {
                cell.layer.add(iconShake, forKey: "iconShakeAnimation")
            }
            
            return cell
        }
        return cellEmpty
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard !isEditEnabled else { return }
        
        collectionView.visibleCells.forEach { cell in
            guard let favoriteCell = cell as? FavoriteLocationCollectionViewCell else { return }
            favoriteCell.locationView.layer.borderWidth = 0.0
        }
        
        if let cell = collectionView.cellForItem(at: indexPath) as? FavoriteLocationCollectionViewCell {
            
            let selectedLocation = listFavoriteLocations[indexPath.row]
            
            cell.locationView.layer.borderWidth = 5.0
            
            if let coord = selectedLocation.coord {
                UserDefaults.selectedFavoriteLocation = Coord(lon: coord.lon, lat: coord.lat)
            }
         }
    }
    
    @objc func removeFavoriteLocation(sender:UIButton)
    {
        var newList: [Coord] = []
        for cord in listFavoriteLocations {
            newList.append(cord.coord!)
        }

        newList.remove(at: sender.tag)
        let selectedLocation = listFavoriteLocations[sender.tag]
                
        if databaseService.emailLoginUser() != ""{
            if let coord = selectedLocation.coord {
                databaseService.removeFavoriteLocation(email: databaseService.emailLoginUser(), coord: coord)
            }
        }
        
        listFavoriteLocations.remove(at: sender.tag)

        newList.removeFirst()

        UserDefaults.favoriteLocations = newList

        self.favoritesView.favoriteLocationsCollectionView.favoriteLocationsCollectionView.reloadData()
    }
    
    
}

extension UIViewController {
    func preloadView() {
        let _ = view
    }
}
