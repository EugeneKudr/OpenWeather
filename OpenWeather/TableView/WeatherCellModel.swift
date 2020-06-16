//
//  WeatherCellModel.swift
//  OpenWeather
//
//  Created by Евгений Испольнов on 09.06.2020.
//  Copyright © 2020 Евгений Испольнов. All rights reserved.
//

import Foundation

struct WeatherCellModel {
    var dates: String
    var meanTemperatures: String
    var descriptions: String
    var winds: String
    var pressures: String
    var humidities: String
    var nightTemperatures = ""
    var morningTemperatures = ""
    var dayTemperatures = ""
    var eveningTemperatures = ""
    var isExpended = false
    var feelsLike = ""
}
