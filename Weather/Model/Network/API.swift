//
//  API.swift
//  Weather
//
//  Created by Sergey Savinkov on 14.03.2024.
//

import Foundation

struct API {
    static let apiKey = "926247ac53ed30b659cab42495a479fd"
    static let api = "https://api.openweathermap.org/data/2.5/onecall?exclude=minutely&lang=ru&units=metric&appid=\(apiKey)&"
}
