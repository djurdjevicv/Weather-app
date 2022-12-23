//
//  WeatherNetworkService.swift
//  Weather app
//
//  Created by praksa on 8.11.22..
//

import Foundation

public class WeatherNetworkingService {
    
    func getCurrentWeather(lat: Double, lon: Double, completion: @escaping (Result<CurrentWeather, Error>) -> Void)  {
        
        guard let unitSystem = UserDefaults.unitSystem else { return }
                
        let url = URL(string: "\(Constants.BaseUrl)data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(Constants.APIid)&units=\(unitSystem)")
        
        guard let requestUrl = url else {
            print("Something wrong happened with URL \(String(describing: url))")
            return
        }
                
        var request = URLRequest(url: requestUrl)
        
        request.httpMethod = HttpMethods.get.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Error took place \(error)")
                completion(.failure(error))
                return
            }
                        
            let decoder = JSONDecoder()
            
            do {
                let res = try decoder.decode(CurrentWeather.self, from: data!)
                completion(.success(res))
            } catch {
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getFiveDayWeather(lat: Double, lon: Double, completion: @escaping (Result<FiveDaysWeather, Error>) -> Void)  {
        
        guard let unitSystem = UserDefaults.unitSystem else { return }
        
        let url = URL(string: "\(Constants.BaseUrl)data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=\(Constants.APIid)&units=\(unitSystem)")
        
        guard let requestUrl = url else {
            print("Something wrong happened with URL \(String(describing: url))")
            return
        }
                
        var request = URLRequest(url: requestUrl)
        
        request.httpMethod = HttpMethods.get.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Error took place \(error)")
                completion(.failure(error))
                return
            }
                        
            let decoder = JSONDecoder()
            
            do {
                let res = try decoder.decode(FiveDaysWeather.self, from: data!)
                completion(.success(res))
            } catch {
                
                print(String(describing: error))
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getDataForWeatherIcon(iconId: String, completion: @escaping (Result<Data, Error>) -> Void)  {
        let url = URL(string: "https://openweathermap.org/img/wn/\(iconId)@2x.png")
        
        guard let requestUrl = url else {
            print("Something wrong happened with URL \(String(describing: url))")
            return
        }
                
        var request = URLRequest(url: requestUrl)
        
        request.httpMethod = HttpMethods.get.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Error took place \(error)")
                completion(.failure(error))
                return
            }
                        
            if let data = data {
                completion(.success(data))
            }
        }
        task.resume()
    }
    
    func getAirQuality(lat: Double, lon: Double, completion: @escaping (Result<AirQuality, Error>) -> Void)  {
        
        guard let unitSystem = UserDefaults.unitSystem else { return }
        
        let url = URL(string: "\(Constants.BaseUrl)data/2.5/air_pollution?lat=\(lat)&lon=\(lon)&appid=\(Constants.APIid)&units=\(unitSystem)")
        
        guard let requestUrl = url else {
            print("Something wrong happened with URL \(String(describing: url))")
            return
        }
        
        var request = URLRequest(url: requestUrl)
        
        request.httpMethod = HttpMethods.get.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Error took place \(error)")
                completion(.failure(error))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let res = try decoder.decode(AirQuality.self, from: data!)
                completion(.success(res))
            } catch {
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getLocation(cityName: String, limit: Int, completion: @escaping (Result<[Location], Error>) -> Void)  {
        
        guard let unitSystem = UserDefaults.unitSystem else { return }
        
        guard let city = cityName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        let urlString = "\(Constants.BaseUrl)geo/1.0/direct?q=\(city))&limit=\(limit)&appid=\(Constants.APIid)&units=\(unitSystem)"
                
        let url = URL(string: urlString)
        
        guard let requestUrl = url else {
            print("Something wrong happened with URL \(String(describing: url))")
            return
        }
        
        var request = URLRequest(url: requestUrl)
        
        request.httpMethod = HttpMethods.get.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Error took place \(error)")
                completion(.failure(error))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let res = try decoder.decode([Location].self, from: data!)
                completion(.success(res))
            } catch {
                print(String(describing: error))
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
