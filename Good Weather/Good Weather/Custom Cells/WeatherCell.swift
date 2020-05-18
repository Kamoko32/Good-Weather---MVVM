//
//  WeatherCell.swift
//  Good Weather
//
//  Created by Kamil Gucik on 05/05/2020.
//  Copyright © 2020 Kamil Gucik. All rights reserved.
//

import Foundation
import UIKit

class WeatherCell: UITableViewCell {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    func configure(_ vm: WeatherViewModel) {
        self.cityNameLabel.text = vm.name.value
        self.temperatureLabel.text = "\(vm.currentTemperature.temperature.value.formatAsDegree)"
    }
}
