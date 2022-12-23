//
//  CurrentWeatherViewController.swift
//  Weather app
//
//  Created by praksa on 9.11.22..
//

import UIKit
import Resolver
import CoreLocation
import Firebase

class HomeScreenViewController: UIViewController {
    
    @Injected var weatherNetworkingService: WeatherNetworkingService

    private let homeScreenView = HomeScreenView()
    private let homeNo = HomeNoFavoritesView()
    private let disabledInternet = InternetDisabledView()
    
    let weatherElements = ["Real feel", "Humidity", "Chance of rain", "Pressure"]
    
    var lat: Double = 0.0
    var lon: Double = 0.0
    
    var oneDayWeatherList: [OneDayWeather] = []
    var currentWeatherDetailsList: [String] = []
    var airQuality: AirQuality!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.setBackgroundGradient()
        let locationAvailable: Bool = (UserDefaults.currentLocation != nil)
        
        if UserDefaults.unitSystem == UnitSystem.fahrenheit.rawValue {
            homeScreenView.unitsLabel.text = "°F"
        } else {
            homeScreenView.unitsLabel.text = "°C"
        } 
        
        if UserDefaults.selectedFavoriteLocation != nil || locationAvailable {
            view = homeScreenView
            if let selectedLocation = UserDefaults.selectedFavoriteLocation {
                lat = selectedLocation.lat
                lon = selectedLocation.lon
                getWeatherData()
                return
            }
            
            if let currentLocation = UserDefaults.currentLocation {
                lat = currentLocation.lat
                lon = currentLocation.lon
                getWeatherData()
            }
        } else if !Reachability.isConnectedToNetwork() {
            view = disabledInternet
            navigationController?.setNavigationBarHidden(true, animated: animated)
            
            disabledInternet.actionTitle.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openSettings)))
        } else {
            view = homeNo
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeScreenView.scrollView.alpha = 0
        homeScreenView.activityIndicator.startAnimating()
        
        self.homeScreenView.weatherDetailsCollectionView.weatherCollectionView.delegate = self
        self.homeScreenView.weatherDetailsCollectionView.weatherCollectionView.dataSource = self
        
        self.homeScreenView.fiveDaysTableView.weatherTableView.delegate = self
        self.homeScreenView.fiveDaysTableView.weatherTableView.dataSource = self
        
        homeNo.searchLocationsButton.addTarget(self, action: #selector(searchLocationsButtonClick), for: .touchUpInside)
    }
    
    public func locationIsAvailable() {
        homeScreenView.dot.isHidden = true
        homeScreenView.turnOnLocationLabel.isHidden = true
        homeScreenView.turnOnLocationButton.isHidden = true
    }
    
    @objc private func searchLocationsButtonClick() {
        guard let tabBar = parent?.parent as? TabBarViewController else { return }
        tabBar.selectedIndex = 1
        navigationController?.popToRootViewController(animated: true)
    }
    
    func getWeatherData(){
        weatherNetworkingService.getCurrentWeather(lat: lat, lon: lon) { result in
            switch result {
            case .success(let currentWeather):
                self.currentWeatherDetailsList.append("\(String(format: "%.0f", currentWeather.main.feels_like))°")
                self.currentWeatherDetailsList.append("\(String(currentWeather.visibility)) m")
                self.currentWeatherDetailsList.append("\(String(currentWeather.clouds.all))%")
                self.currentWeatherDetailsList.append("\(String(currentWeather.main.pressure)) mBar")
                
                DispatchQueue.main.async {
                    self.homeScreenView.weatherDetailsCollectionView.weatherCollectionView.reloadData()
                    self.navigationController?.navigationBar.topItem?.title = currentWeather.name
                    self.homeScreenView.cloudyLabel.text = currentWeather.weather[0].main
                    self.homeScreenView.humidityLabel.text = "\(currentWeather.main.humidity)%"
                    self.homeScreenView.degreesLabel.text = ("\(Int(currentWeather.main.temp))")
                    self.homeScreenView.dateLabel.text = self.getCurrantDate()
                    self.homeScreenView.windLabel.text = String(format: "%.2f", currentWeather.wind.speed) + "km/h"
                    self.homeScreenView.layoutSubviews()
                }
            case .failure(let error):
                print(error)
            }
        }
        
        oneDayWeatherList = []
        
        weatherNetworkingService.getFiveDayWeather(lat: lat, lon: lon) { [self] result in
            switch result {
            case .success(let fiveDays):
                
                for index in 0...4 {
                    if let oneDay = getWeather(currentWeatherList: fiveDays.list, countDay: index, date: Date()) {
                        oneDayWeatherList.append(oneDay)
                        
                        DispatchQueue.main.async {
                            self.homeScreenView.fiveDaysTableView.weatherTableView.reloadData()
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
        
        weatherNetworkingService.getAirQuality(lat: lat, lon: lon) { result in
            switch result {
            case .success(let airQuality):
                
                self.airQuality = airQuality
                DispatchQueue.main.async {
                    self.homeScreenView.airQualityLabel.text = "AQI \(String(airQuality.list[0].main.aqi!))"
                    self.homeScreenView.layoutSubviews()
                    self.homeScreenView.scrollView.alpha = 1
                    self.homeScreenView.activityIndicator.stopAnimating()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getCurrantDate() -> String {
        var result: String = ""
        
        let date = Date()
        
        //MONTH
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "LLLL"
        let monthString = monthFormatter.string(from: date)
        
        //DAY OF WEEK
        let dayOfWeekFormatter = DateFormatter()
        dayOfWeekFormatter.dateFormat = "EEEE"
        let dayOfTheWeekString = dayOfWeekFormatter.string(from: date)

        //DAY
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: date)
        let dayOfMonth = components.day

        result = "\(dayOfTheWeekString), \(dayOfMonth!) \(monthString)"
        
        return result
    }
        
    func getWeather(currentWeatherList: [CurrentWeather], countDay: Int, date: Date) -> OneDayWeather? {
        
        var maxTempList: [Double] = []
        var minTempList: [Double] = []
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dayOfWeekFormatter = DateFormatter()
        dayOfWeekFormatter.dateFormat = "EEEE"
        
        var dateString = ""
        var dayOfTheWeekString = ""
        
        if let date = Calendar.current.date(byAdding: .day, value: countDay, to: date) {
            dateString = formatter.string(from: date)
            dayOfTheWeekString = dayOfWeekFormatter.string(from: date)
        }
        
        var descriptionArray: [String] = []
        var countDesc = [String: Int]()
        var usuallyWeatherDescription = ""
        
        var iconArray: [String] = []
        var countIcon = [String: Int]()
        var usualyWeatherIcon = ""
        
        for oneDay in currentWeatherList{
            if let dateFromList = oneDay.dt_txt?.prefix(10) {
                if dateString == dateFromList {
                    maxTempList.append(oneDay.main.temp_max)
                    minTempList.append(oneDay.main.temp_min)
                    
                    descriptionArray.append(oneDay.weather[0].main)
                    
                    descriptionArray.forEach { countDesc[$0] = (countDesc[$0] ?? 0) + 1 }

                    if let (value, _) = countDesc.max(by: {$0.1 < $1.1}) {
                        usuallyWeatherDescription = value
                    }
                    
                    iconArray.append(oneDay.weather[0].icon)
                    
                    iconArray.forEach { countIcon[$0] = (countIcon[$0] ?? 0) + 1 }

                    if let (value, _) = countIcon.max(by: {$0.1 < $1.1}) {
                        usualyWeatherIcon = value
                    }
                }
            }
        }
                
        if let min = minTempList.min(), let max = maxTempList.max() {
            let oneDayWeather = OneDayWeather(minTemp: min, maxTemp: max, dayOfTheWeek: dayOfTheWeekString, weatherDescription: usuallyWeatherDescription, weatherIcon: usualyWeatherIcon)
            return oneDayWeather
        }
        return nil
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
    
}


extension HomeScreenViewController: UICollectionViewDataSource, UICollectionViewDelegate {
 
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

extension HomeScreenViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return oneDayWeatherList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.fiveDaysWeatherTableViewCell, for: indexPath) as? FiveDaysWeatherTableViewCell {

            cell.backgroundColor = .clear
            cell.selectionStyle = .none
                        
            if !oneDayWeatherList.isEmpty {

                var oneDay = oneDayWeatherList[indexPath.row]
                                
                oneDay.weatherIcon = oneDay.weatherIcon.replacingOccurrences(of: "n", with: "d")
                cell.icon.image = UIImage(named: oneDay.weatherIcon)
                
                if String(format: "%.0f", oneDay.minTemp) == "-0" {
                    oneDay.minTemp = 0
                }else if String(format: "%.0f", oneDay.maxTemp) == "-0" {
                    oneDay.maxTemp = 0
                }
                
                cell.minTemp.text = "\(String(format: "%.0f", oneDay.minTemp))°"
                cell.maxTemp.text = "\(String(format: "%.0f", oneDay.maxTemp))°"
                
                cell.weatherDescription.text = oneDay.weatherDescription

                if indexPath.row == 0 {
                    cell.dayOfWeek.text = "Today"
                } else if indexPath.row == 1 {
                    cell.dayOfWeek.text = "Tomorrow"
                } else {
                    cell.dayOfWeek.text = oneDay.dayOfTheWeek
                }
                
            }
            return cell
        }
        return UITableViewCell()
    }


}

