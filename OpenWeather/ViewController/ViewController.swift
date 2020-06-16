//
//  ViewController.swift
//  OpenWeather
//
//  Created by Евгений Испольнов on 03.06.2020.
//  Copyright © 2020 Евгений Испольнов. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var networkManager: NetworkManager!
    var tableViewData = [WeatherCellModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "WeatherCell", bundle: nil), forCellReuseIdentifier: "WeatherCell")
        tableView.register(UINib(nibName: "WeatherTodayCell", bundle: nil), forCellReuseIdentifier: "WeatherTodayCell")
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        
        searchBar.text = "Введите город"

        networkManager = NetworkManager()
    }
}

//MARK: UISearchBar methods
extension ViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        tableViewData = []
        distributeRequestForCity()
    }
}

//MARK: UITableView methods
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return tableViewData.isEmpty ? 0 : 1
        } else {
            return tableViewData.count - 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTodayCell", for: indexPath) as! WeatherTodayTableViewCell
            
            cell.setData(data: tableViewData[0])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherTableViewCell
            
            cell.setData(data: tableViewData[indexPath.row + 1])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            tableViewData[0].isExpended.toggle()
        } else {
            tableViewData[indexPath.row + 1].isExpended.toggle()
        }
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if !tableViewData.isEmpty {
            if section == 0 {
                return "Текущая погода"
            } else {
                return "Прогноз погоды"
            }
        } else {
            return ""
        }
    }
}

//MARK: Private methods
extension ViewController {
    private func update() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func distributeRequestForCity() {
        if let city = searchBar.text {
            getCurrentWeather(city)
            getForecast(city)
        }
    }
    
    private func getCurrentWeather(_ city: String) {
        networkManager.getCurrentWeather(city) { [weak self] weather, error in
            
            let date = "Прямо сейчас"
            var temperature: Double
            var description: String
            var wind: Double
            var pressure: Int
            var humidity: Int
            var feelsLike: Double
            
            if let weather = weather {
                guard let strongSelf = self else { return }
                
                
                temperature = weather.main.temp
                description = weather.weather.first!.description.capitalized
                wind = weather.wind.speed
                pressure = weather.main.pressure
                humidity = weather.main.humidity
                feelsLike = weather.main.feelsLike
                
                strongSelf.tableViewData.append(WeatherCellModel(dates: date,
                                                meanTemperatures: String(temperature),
                                                descriptions: description,
                                                winds: String(wind),
                                                pressures: String(Int(Double(pressure) * 0.750062)),
                                                humidities: String(humidity),
                                                feelsLike: String(feelsLike)))
                
                strongSelf.update()
            }
        }
    }
    
    private func getForecast(_ city: String) {
        networkManager.getForecast(city) { [weak self] weather, error in
            
            var dateArray: [String] = []
            var temperatureArray: [Double] = []
            var descriptionArray: [String] = []
            var windArray: [Double] = []
            var pressureArray: [Int] = []
            var humidityArray: [Int] = []
            
            if let weather = weather {
                guard let strongSelf = self else { return }
                
                for item in weather.list {
                    dateArray.append(item.date)
                    temperatureArray.append(item.main.temp)
                    descriptionArray.append(item.weather.first!.description.capitalized)
                    windArray.append(item.wind.speed)
                    pressureArray.append(item.main.pressure)
                    humidityArray.append(item.main.humidity)
                }
        
                strongSelf.splitForecastForDays(dateArray,
                                                temperatureArray,
                                                descriptionArray,
                                                windArray,
                                                pressureArray,
                                                humidityArray)
                
                strongSelf.update()
            }
        }
    }
    
    private func splitForecastForDays(_ dateArray: [String],
                                      _ temperatureArray: [Double],
                                      _ descriptionArray: [String],
                                      _ windArray: [Double],
                                      _ pressureArray: [Int],
                                      _ humidityArray: [Int]) {
        
        var indexes: [Int] = []
        for number in 1..<dateArray.count {
            if dateArray[number][dateArray[number].index(dateArray[number].startIndex, offsetBy: 12)] == "0" {
                indexes.append(number)
            }
        }
        
        if indexes.count > 4 {
            indexes = indexes.dropLast()
        }
        
        for number in indexes {
            tableViewData.append(WeatherCellModel(dates: String(dateArray[number].dropLast(9)),
                                                  meanTemperatures: String(temperatureArray[number+4]),
                                                  descriptions: descriptionArray[number+4],
                                                  winds: String(windArray[number+4]),
                                                  pressures: String(Int(Double(pressureArray[number+4]) * 0.750062)),
                                                  humidities: String(humidityArray[number+4]),
                                                  nightTemperatures: String(temperatureArray[number]),
                                                  morningTemperatures: String(temperatureArray[number+2]),
                                                  dayTemperatures: String(temperatureArray[number+4]),
                                                  eveningTemperatures: String(temperatureArray[number+7])))
        }
    }
}
