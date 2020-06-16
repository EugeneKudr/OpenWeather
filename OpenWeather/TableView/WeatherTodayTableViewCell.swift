//
//  WeatherTodayTableViewCell.swift
//  OpenWeather
//
//  Created by Евгений Испольнов on 10.06.2020.
//  Copyright © 2020 Евгений Испольнов. All rights reserved.
//

import UIKit

class WeatherTodayTableViewCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

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
        feelsLikeLabel.text = "Ощущается как \(data.feelsLike)°C"
        
        container.isHidden = !data.isExpended
    }

}
