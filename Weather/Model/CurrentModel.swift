//
//  Model.swift
//  Weather
//
//  Created by Sergey Savinkov on 14.03.2024.
//

import Foundation

struct WeatherResponse: Decodable {
    let lat, lon: Double
    let current: Current
    let daily: [DailyWeather]
}

struct Current: Decodable {
    let dt, temp: Double
    let pressure: Int
    let humidity: Int
    let wind_speed: Double
    let weather: [WeatherInfo]
}

struct WeatherInfo: Decodable {
    let description, icon: String
}

struct DailyWeather: Decodable {
    let dt: Double
    let temp: DailyTemp
}

struct DailyTemp: Decodable {
    let min, max: Double
}

struct CurrentModel: Codable {
    let coord: Coord
}

struct Coord: Codable {
    let lat, lon: Double
}
//MARK: - CurrentWeatherData

struct CurrentWeatherData: Codable {
   let main: Main
   let name: String
   let weather: [Weather]
}

struct Main: Codable {
   let temp: Double
   let feelsLike: Double
   let tempMin: Double
   let tempMax: Double
   
   enum CodingKeys: String, CodingKey {
       case temp
       case feelsLike = "feels_like"
       case tempMin = "temp_min"
       case tempMax = "temp_max"
   }
}

struct Weather: Codable {

   let icon: String
   let weatherDescription: String
   
   enum CodingKeys: String, CodingKey {
       case weatherDescription = "description"
       case icon
}
   var myDescription: String {
       switch weatherDescription {
       case "clear sky": return "Ясно"
       case "few clouds": return "Облачно"
       case "scattered clouds": return "Облачно"
       case "broken clouds": return "Облачно"
       case "shower rain": return "Сильный дождь"
       case "rain": return "Дождь"
       case "thunderstorm": return "Гроза"
       case "snow": return "Снег"
       case "mist": return "Туман"
       default: return "No data"
       }
   }
}
