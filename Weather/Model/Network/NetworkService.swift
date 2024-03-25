//
//  WeatherNetwork.swift
//  SimpleWeather
//
//  Created by Sergey Savinkov on 18.09.2023.
//

import UIKit

protocol NetworkProtocol {
    func fetchCurrentWeather(city: String, completion: @escaping (WeatherResponse) -> ())
    func getWeather(coordinates: String, completion: @escaping(WeatherResponse?) -> (Void))
}

class NetworkService: NetworkProtocol {
    func fetchCurrentWeather(city: String, completion: @escaping (WeatherResponse) -> Void) {
        
        let formatCity = city.replacingOccurrences(of: " ", with: "+")
        let apiURL = "https://api.openweathermap.org/data/2.5/weather?q=\(formatCity)&appid=\(API.apiKey)&lang=ru"
       
        guard let url = URL(string: apiURL) else { fatalError() }
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { (data, responce, error) in
            guard let data = data else { return }
            do {
                let currentModel = try JSONDecoder().decode(WeatherResponse.self, from: data)
                completion(currentModel)
            } catch {
                print(error)
            }
        }
        .resume()
    }
    
    func getWeather(coordinates: String, completion: @escaping (WeatherResponse?) -> Void) {
        let apiUrl = "\(API.api)\(coordinates)"
        
        guard let url = URL(string: apiUrl) else { fatalError() }
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let currentModel = try JSONDecoder().decode(WeatherResponse?.self, from: data)
                completion(currentModel)
            } catch {
                print(error)
            }
        }
        .resume()
    }
}
