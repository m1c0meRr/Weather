//
//  CurrentWeaterViewModel.swift
//  Weather
//
//  Created by Sergey Savinkov on 21.03.2024.
//

import UIKit

enum WeatherEnum {
    
    enum Model {
        struct Request {
            enum RequestType {
                case getWeather
            }
        }
        
        struct Response {
            enum ResponseType {
                case presentWeather(weather: WeatherResponse, locality: String)
             //   case presentCity(cityWeather: CurrentModel, locality: String)
            }
        }
        
        struct ViewModel {
            enum ViewModelData {
                case displayWeather(currentWeatherViewModel: CurrentWeatherViewModel)
            }
        }
    }
}

struct CurrentWeatherViewModel {
    let locality: String
    let temp: String
    let weatherDescription: String
    let pressure: String
    let humidity: String
    let maxMinTemp: String
    let dailyWeather: [Daily]
    let windLabel: String
    
    struct Daily {
        var dt: String
        let minTemp: String
        let maxTemp: String
    }
}
