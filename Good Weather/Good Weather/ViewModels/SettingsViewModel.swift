//
//  SettingsViewModel.swift
//  Good Weather
//
//  Created by Kamil Gucik on 07/05/2020.
//  Copyright © 2020 Kamil Gucik. All rights reserved.
//

import Foundation

enum Unit: String, CaseIterable {
    
    case celsius = "metric"
    case fahrenheit = "imperial"
}

extension Unit {
    
    var displayName: String {
        get {
            switch (self) {
            case .celsius:
                return "Celsius"
            case .fahrenheit:
                return "Fahrenheit"
            }
        }
    }
}

struct SettingsViewModel {
    
    let units = Unit.allCases
    private var _selectedUnit: Unit = Unit.celsius
    
    var selectedUnit: Unit {
        get{
            let userDefaults = UserDefaults.standard
            if let value = userDefaults.value(forKey: "unit") as? String {
                return Unit(rawValue: value)!
            }
            return _selectedUnit
        } set {
            let userDeafults = UserDefaults.standard
            userDeafults.set(newValue.rawValue, forKey: "unit")
        }
    }
    
}
