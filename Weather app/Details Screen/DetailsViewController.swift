//
//  DetailsViewController.swift
//  Weather app
//
//  Created by praksa on 17.11.22..
//

import UIKit
import Resolver

class DetailsViewController: UIViewController {

    @Injected var weatherNetworkingService: WeatherNetworkingService
    @Injected var databaseService: DatabaseService
    
    var lon: Double = 0.0
    var lat: Double = 0.0
    var city: String = ""
    var country: String = ""
    private let detailsView = DetailsView()
    
    var currentWeatherDetailsList: [String] = []
    let weatherElements = ["Real feel", "Humidity", "Chance of rain", "Pressure"]

    var listWeatherByHour: [WeatherByHour] = []
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view = detailsView
        let isAlreadyAddedLocation = checkUserFavoritesLocations()
        if !isAlreadyAddedLocation {
            detailsView.addLocationButton.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.detailsView.weatherDetailsCollectionView.weatherCollectionView.delegate = self
        self.detailsView.weatherDetailsCollectionView.weatherCollectionView.dataSource = self
                
        weatherNetworkingService.getCurrentWeather(lat: lat, lon: lon) { result in
            switch result {
            case .success(let currentWeather):
                self.currentWeatherDetailsList.append("\(String(format: "%.0f", currentWeather.main.feels_like))°")
                self.currentWeatherDetailsList.append("\(String(currentWeather.visibility)) m")
                self.currentWeatherDetailsList.append("\(String(currentWeather.clouds.all))%")
                self.currentWeatherDetailsList.append("\(String(currentWeather.main.pressure)) mBar")
                
                let nowWeather = WeatherByHour(hour: "Now", temp: "\(Int(currentWeather.main.temp))°", weatherIcon: currentWeather.weather[0].icon, windIcon: "", wind: String(format: "%.2f", currentWeather.wind.speed) + "km/h")
                                
                self.listWeatherByHour.append(nowWeather)
                
                DispatchQueue.main.async {
                    self.detailsView.weatherDetailsCollectionView.weatherCollectionView.reloadData()
                    self.navigationController?.navigationBar.topItem?.title = currentWeather.name
                    self.detailsView.cityLabel.text = self.city
                    self.detailsView.countryLabel.text = self.country
                    self.detailsView.humidityLabel.text = "\(currentWeather.main.humidity)%"
                    
                    if UserDefaults.unitSystem == UnitSystem.fahrenheit.rawValue {
                        if String(format: "%.0f", currentWeather.main.temp) == "-0" {
                            self.detailsView.temperatureLabel.text = "0°F"
                        } else {
                            self.detailsView.temperatureLabel.text = "\(String(format: "%.0f", currentWeather.main.temp))°F"
                        }
                    } else {
                        if String(format: "%.0f", currentWeather.main.temp) == "-0" {
                            self.detailsView.temperatureLabel.text = "0°C"
                        } else {
                            self.detailsView.temperatureLabel.text = "\(String(format: "%.0f", currentWeather.main.temp))°C"
                        }
                    }
                    
                    self.detailsView.windLabel.text = String(format: "%.2f", currentWeather.wind.speed) + "km/h"
                    //self.detailsView.weatherIcon.image = UIImage(named: currentWeather.weather[0].icon)
                    self.detailsView.weatherIcon.image = UIImage(named: "11d")
                    self.detailsView.layoutSubviews()
                }
            case .failure(let error):
                print(error)
            }
        }
        
        self.getWeatherByHour()
        
        detailsView.addLocationButton.addTarget(self, action: #selector(addLocationButtonPresses), for: .touchUpInside)
    }
    
    func createHourWeatherView(){
        for oneWeather in self.listWeatherByHour {
            let view = DayWeatherView()
            view.translatesAutoresizingMaskIntoConstraints = false
            
            view.timeLabel.text = oneWeather.hour
            view.temperatureLabel.text = oneWeather.temp
            view.weatherIcon.image = UIImage(named: oneWeather.weatherIcon)
            view.windLabel.text = oneWeather.wind
                                
            self.detailsView.stackViewDayWeather.addArrangedSubview(view)
        }
    }
    
    func getWeatherByHour(){
        weatherNetworkingService.getFiveDayWeather(lat: lat, lon: lon) { result in
            switch result {
            case .success(let fiveDays):
                
                let date = Date()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                let dateString = formatter.string(from: date)
                        
                for oneWeather in fiveDays.list {
                    if let dateFromList = oneWeather.dt_txt?.prefix(10) {
                        if dateString == dateFromList {
                            if let hour = (oneWeather.dt_txt?.suffix(8).prefix(5)) {
                                let nowWeather = WeatherByHour(hour: String(hour), temp: "\(Int(oneWeather.main.temp))°", weatherIcon: oneWeather.weather[0].icon, windIcon: "", wind: String(format: "%.2f", oneWeather.wind.speed) + "km/h")
                                                
                                self.listWeatherByHour.append(nowWeather)
                            }
                        }
                    }
                }
                
                DispatchQueue.main.async {
                    self.createHourWeatherView()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func checkUserFavoritesLocations() -> Bool{
        
        let latFormated = Double(round(10000 * lat) / 10000)
        let lonFormated = Double(round(10000 * lon) / 10000)
        
        if let locations = UserDefaults.favoriteLocations {
            for location in locations {
                if latFormated == location.lat && lonFormated == location.lon {
                    return false
                }
            }
        }
        return true
    }
    
    @objc private func addLocationButtonPresses() {
        
        detailsView.addLocationButton.isHidden = true
        
        let newLocation = Coord(lon: lon, lat: lat)
        
        if databaseService.emailLoginUser() != "" {
            databaseService.saveNewFavoriteLocation(email: databaseService.emailLoginUser(), location: newLocation)
        }
        
        if var favoriteLocation = UserDefaults.favoriteLocations {
            
            print(newLocation)
            
            favoriteLocation.append(newLocation)
            
            let newList = favoriteLocation
            
            UserDefaults.favoriteLocations = newList
                        
            successfulAddLocationAlert(alertMessage: "Successful add location to favorite locations")
            
        } else {
            UserDefaults.favoriteLocations = [newLocation]
            successfulAddLocationAlert(alertMessage: "Successful add location to favorite locations")
            
        }
    }
    
    func successfulAddLocationAlert(alertMessage: String){
        let alert = UIAlertController(title: alertMessage, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
}


extension DetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherElements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.weatherDetailCell, for: indexPath) as? WeatherDetailsCollectionViewCell {
            
            cell.detailName.text = weatherElements[indexPath.row]
            
            if !currentWeatherDetailsList.isEmpty{
                cell.detailValue.text = currentWeatherDetailsList[indexPath.row]
            }
            
            return cell
        }
    
        return UICollectionViewCell()
    }
    
}
