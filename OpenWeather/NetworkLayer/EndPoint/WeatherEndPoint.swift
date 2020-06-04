//
//  WeatherEndPoint.swift
//  OpenWeather
//
//  Created by Евгений Испольнов on 03.06.2020.
//  Copyright © 2020 Евгений Испольнов. All rights reserved.
//

import Foundation

public enum WeatherApi {
    case currentWeather
    case forecast
}

extension WeatherApi: EndPointType {
    
    var environmentBaseURL : String {
        return "https://api.openweathermap.org/data/2.5/"
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .forecast:
            return "forecast"
        case .currentWeather:
            return "weather"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .currentWeather:
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: ["q":"penza", "appid":NetworkManager.MovieAPIKey, "units":"metric", "lang":"ru"])
        case .forecast:
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: ["q":"penza", "appid":NetworkManager.MovieAPIKey, "units":"metric", "lang":"ru"])
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
