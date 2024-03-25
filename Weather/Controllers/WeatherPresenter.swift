//
//  WeatherPresenter.swift
//  Weather
//
//  Created by Sergey Savinkov on 23.03.2024.
//

import UIKit

protocol WeatherPresentationLogic {
    func presentData(response: WeatherEnum.Model.Response.ResponseType)
}

class WeatherPresenter: WeatherPresentationLogic {
    
    weak var viewController: WeatherDisplayLogic?
    
    let dateFormatter: DateFormatter = {
        let dt = DateFormatter()
        dt.locale = Locale(identifier: "ru_RU")
        return dt
    }()
    
    //MARK: - PresentData
    
    func presentData(response: WeatherEnum.Model.Response.ResponseType) {
        
        switch response {
            
        case .presentWeather(let weather, let locality):
            var dailyCells: [CurrentWeatherViewModel.Daily] = []
            
            weather.daily.forEach { daily in
                
                dailyCells.append(CurrentWeatherViewModel.Daily.init(dt: formattedDate(dateFormat: "EEEE",
                                                                                       date: daily.dt),
                                                                     minTemp: setSign(temp: Int(daily.temp.min)),
                                                                     maxTemp: setSign(temp: Int(daily.temp.max)))
                )}
            
            dailyCells[0].dt = "Cегодня"
            let maxMinTemp = "Мин.: \(dailyCells[0].minTemp), макс.: \(dailyCells[0].maxTemp)"
            let windLabel = "Cкорость ветра: \(weather.current.wind_speed) м/с"
            let pressureLabel = "Давление: \(weather.current.pressure) мм рт. ст."
            let humidityLabel = "Влажность: \(weather.current.humidity) %"
            let currentWeather = headerViewModel(weatherModel: weather,
                                                 windLabel: windLabel,
                                                 pressure: pressureLabel,
                                                 humidity: humidityLabel,
                                                 maxMinTemp: maxMinTemp,
                                                 dailyCells: dailyCells,
                                                 locality: locality)
            
            viewController?.displayData(viewModel: .displayWeather(currentWeatherViewModel: currentWeather))
        }
    }
    
    private func formattedDate(dateFormat: String, date: Double) -> String {
        dateFormatter.dateFormat = dateFormat
        let currentDate = Date(timeIntervalSince1970: date)
        let dateTitle = dateFormatter.string(from: currentDate).capitalizingFirstLetter()
        return dateTitle
    }
    
    private func setSign(temp: Int) -> String {
        var currentTemp: String = ""
        guard temp >= 1 else { currentTemp = "\(temp)º"; return currentTemp }
        currentTemp = "+\(temp)º"
        return currentTemp
    }
    
    private func headerViewModel(weatherModel: WeatherResponse, windLabel: String, pressure: String, humidity: String , maxMinTemp: String, dailyCells: [CurrentWeatherViewModel.Daily], locality: String) -> CurrentWeatherViewModel{
        return CurrentWeatherViewModel.init(locality: locality,
                                            temp: setSign(temp: Int(weatherModel.current.temp)),
                                            weatherDescription: weatherModel.current.weather.first?.description ?? "null",
                                            pressure: pressure,
                                            humidity: humidity,
                                            maxMinTemp: maxMinTemp,
                                            dailyWeather: dailyCells, windLabel: windLabel)
    }
}
