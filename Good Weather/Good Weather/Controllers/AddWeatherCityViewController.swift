//
//  AddWeatherCityViewController.swift
//  Good Weather
//
//  Created by Kamil Gucik on 05/05/2020.
//  Copyright © 2020 Kamil Gucik. All rights reserved.
//

import Foundation
import UIKit

protocol AddWeatherDelegate {
    func addWeatherDidSave(vm: WeatherViewModel)
}

class AddWeatherCityViewController: UIViewController {
    
    
    var delegate: AddWeatherDelegate?
    @IBOutlet weak var stateTextField: BindingTextField!{
        didSet {
            stateTextField.bind { self.addCityViewModel.state = $0 }
        }
    }
    @IBOutlet weak var zipCodeTextField: BindingTextField!{
        didSet {
            zipCodeTextField.bind { self.addCityViewModel.zipCode = $0 }
        }
    }
    @IBOutlet weak var cityNameTextField: BindingTextField! {
        didSet {
            cityNameTextField.bind { self.addCityViewModel.city = $0 }
        }
    }
    
    private var addCityViewModel = AddCityViewModel()
    
    @IBAction func saveCityButtonPressed() {
        
        if let city = cityNameTextField.text {
            let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=567434e377e156acdcfb068ff9550169&units=imperial")!
            
            let weatherResource = Resource<WeatherViewModel>(url: weatherURL) { data in
                
                let weatherVM = try? JSONDecoder().decode(WeatherViewModel.self, from: data)
                return weatherVM
            }
            
            Webservice().load(resource: weatherResource) { [weak self] result in
                
                if let weatherVM = result {
                    
                    if let delegate = self?.delegate {
                        delegate.addWeatherDidSave(vm: weatherVM)
                        self?.dismiss(animated: true, completion: nil)
                    }
                }
                
            }
        }
    }
    
    
    
}
