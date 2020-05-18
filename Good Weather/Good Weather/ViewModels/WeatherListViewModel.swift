//
//  WeatherListViewModel.swift
//  Good Weather
//
//  Created by Kamil Gucik on 05/05/2020.
//  Copyright © 2020 Kamil Gucik. All rights reserved.
//

import Foundation

class WeatherListViewModel {
    
    private(set) var weatherViewModels = [WeatherViewModel]()
    
     func addWeatherViewModel(_ vm: WeatherViewModel) {
        self.weatherViewModels.append(vm)
    }
    
    func numberOfRows(_ section: Int) -> Int {
        return self.weatherViewModels.count
    }
    
    func modelAt(_ index: Int) ->WeatherViewModel {
        return self.weatherViewModels[index]
    }
    
     func updateUnit(to unit: Unit) {
        
        switch unit {
        case .celsius:
            toCelsius()
        case .fahrenheit:
            toFahrenheit()
        }
    }
    
    private func toCelsius() {
    weatherViewModels = weatherViewModels.map { vm in
        
        let weatherModel = vm
        weatherModel.currentTemperature.temperature.value = (weatherModel.currentTemperature.temperature.value - 32) * 5/9
        return weatherModel
    }
    }
    
    
    
     private func toFahrenheit() {
        weatherViewModels = weatherViewModels.map { vm in
        
        let weatherModel = vm
            weatherModel.currentTemperature.temperature.value = (weatherModel.currentTemperature.temperature.value + 9/5) + 35
        return weatherModel
    }
    
}
}

class Dynamic<T>: Decodable where T: Decodable {
    
    typealias Listener = (T) -> ()
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    func bind(listener: @escaping Listener) {
        self.listener = listener
        self.listener?(self.value)
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    private enum CodingKeys: CodingKey {
        case value
    }
}






struct WeatherViewModel : Decodable {
    
    var currentTemperature: TemeratureViewModel
    let name: Dynamic<String>
        
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = Dynamic(try container.decode(String.self, forKey: .name))
        currentTemperature = try container.decode(TemeratureViewModel.self, forKey: .currentTemperature)
    }
    
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case currentTemperature = "main"
    }
 
}

struct TemeratureViewModel:Decodable {
    
    var temperature: Dynamic<Double>
    let temperatureMin: Dynamic<Double>
    let temperatureMax: Dynamic<Double>
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        temperature = Dynamic(try container.decode(Double.self, forKey: .temperature))
        temperatureMax = Dynamic(try container.decode(Double.self, forKey: .temperatureMax))
        temperatureMin = Dynamic(try container.decode(Double.self, forKey: .temperatureMin))
    }
    
    private enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case temperatureMin = "temp_min"
        case temperatureMax = "temp_max"
    }
}

