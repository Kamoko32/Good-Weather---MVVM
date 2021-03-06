//
//  WeatherDataSource.swift
//  Good Weather
//
//  Created by Kamil Gucik on 08/05/2020.
//  Copyright © 2020 Kamil Gucik. All rights reserved.
//

import Foundation
import UIKit

class WeatherDataSource: NSObject, UITableViewDataSource {
    
    let cellIdentifier: String = "WeatherCell"
    private var weatherListViewModel: WeatherListViewModel
    
    init (_ weatherListViewModel: WeatherListViewModel) {
        self.weatherListViewModel = weatherListViewModel
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherListViewModel.weatherViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? WeatherCell else {
            fatalError("Cell not found")
        }
        
        let weatherVM = self.weatherListViewModel.modelAt(indexPath.row)
        
        cell.cityNameLabel.text = weatherVM.name.value
        cell.temperatureLabel.text = weatherVM.currentTemperature.temperature.value.formatAsDegree
        
        return cell
    }
    
    
}
