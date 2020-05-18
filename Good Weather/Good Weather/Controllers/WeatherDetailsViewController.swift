//
//  WeatherDetailsViewController.swift
//  Good Weather
//
//  Created by Kamil Gucik on 07/05/2020.
//  Copyright © 2020 Kamil Gucik. All rights reserved.
//

import Foundation
import UIKit

class WeatherDetailsViewController: UIViewController {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    
    var weatherViewModel: WeatherViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVMBinding()
    }
    
    private func setupVMBinding() {
        
        if let weatherVM = self.weatherViewModel {
            weatherVM.name.bind { self.cityNameLabel.text = $0 }
            weatherVM.currentTemperature.temperature.bind { self.currentTemperatureLabel.text = $0.formatAsDegree }
            

        }
    }
}

