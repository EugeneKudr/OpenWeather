//
//  Weather.swift
//  OpenWeather
//
//  Created by Евгений Испольнов on 03.06.2020.
//  Copyright © 2020 Евгений Испольнов. All rights reserved.
//

import Foundation

struct WeatherForecast: Decodable {
    let list: [ForecastLocalWeather]
}

struct ForecastLocalWeather: Decodable {
    let clouds: Clouds
    let main: Main
    let weather: [Weather]
    let wind: Wind
    let date: String
    
    private enum CodingKeys: String, CodingKey {
        case clouds, main, weather, wind, date = "dt_txt"
    }
}

struct CurrentLocalWeather: Decodable {
    let clouds: Clouds
    let main: Main
    let weather: [Weather]
    let wind: Wind
}

struct Clouds: Decodable {
    let all: Int
}

struct Coord: Decodable {
    let lat: Double
    let lon: Double
}

struct Main: Decodable {
    let humidity: Int
    let pressure: Int
    let temp: Double
    let tempMax: Double
    let tempMin: Double
    private enum CodingKeys: String, CodingKey {
        case humidity, pressure, temp, tempMax = "temp_max", tempMin = "temp_min"
    }
}

struct Weather: Decodable {
    let description: String
    let icon: String
    let id: Int
    let main: String
}

struct Wind: Decodable {
    let deg: Int
    let speed: Double
}

