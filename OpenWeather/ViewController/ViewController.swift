//
//  ViewController.swift
//  OpenWeather
//
//  Created by Евгений Испольнов on 03.06.2020.
//  Copyright © 2020 Евгений Испольнов. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var networkManager: NetworkManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager = NetworkManager()
        networkManager.getCurrentWeather() { weather, error in
            if let error = error {
                print(error)
            }
            
            if let weather = weather {
                print("Температура сейчас: \(weather.main.temp) C")
                print("Погода сейчас: \(weather.weather.first!.description.capitalized)")
            }
        }
        
        networkManager.getForecast() { weather, error in
            if let error = error {
                print(error)
            }
            
            if let weather = weather {
                print("Температура \(weather.list[1].date): \(weather.list[1].main.temp) C")
            }
        }
        
    }

}

