//
//  WeatherTableViewCell.swift
//  OpenWeather
//
//  Created by Евгений Испольнов on 07.06.2020.
//  Copyright © 2020 Евгений Испольнов. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var nightTempLabel: UILabel!
    @IBOutlet weak var morningTempLabel: UILabel!
    @IBOutlet weak var dayTempLabel: UILabel!
    @IBOutlet weak var eveningTempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        // Configure the view for the selected state
    }
    
    func setData(data: WeatherCellModel) {
        dateLabel.text = data.dates
        temperatureLabel.text = "\(data.meanTemperatures)°C"
        descriptionLabel.text = data.descriptions
        windLabel.text = "Ветер \(data.winds) м/с"
        pressureLabel.text = "Давление \(data.pressures) мм"
        humidityLabel.text = "Влажность \(data.humidities)%"
        nightTempLabel.text = "Ночью\n\(data.nightTemperatures)°C"
        morningTempLabel.text = "Утром\n\(data.morningTemperatures)°C"
        dayTempLabel.text = "Днем\n\(data.dayTemperatures)°C"
        eveningTempLabel.text = "Вечером\n\(data.eveningTemperatures)°C"
        
        container.isHidden = !data.isExpended
    }

}
