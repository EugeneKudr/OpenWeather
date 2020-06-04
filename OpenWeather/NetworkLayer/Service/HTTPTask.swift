//
//  HTTPTask.swift
//  OpenWeather
//
//  Created by Евгений Испольнов on 03.06.2020.
//  Copyright © 2020 Евгений Испольнов. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String:String]

public enum HTTPTask {
    case request
    
    case requestParameters(bodyParameters: Parameters?, bodyEncoding: ParameterEncoding, urlParameters: Parameters?)
    
    case requestParametersAndHeaders(bodyParameters: Parameters?, bodyEncoding: ParameterEncoding, urlParameters: Parameters?, additionHeaders: HTTPHeaders?)    
}
