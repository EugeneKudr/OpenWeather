//
//  HTTPMethod.swift
//  OpenWeather
//
//  Created by Евгений Испольнов on 03.06.2020.
//  Copyright © 2020 Евгений Испольнов. All rights reserved.
//

import Foundation

public enum HTTPMethod : String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}
