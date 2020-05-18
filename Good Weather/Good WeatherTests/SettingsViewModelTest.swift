//
//  SettingsViewModelTest.swift
//  Good WeatherTests
//
//  Created by Kamil Gucik on 08/05/2020.
//  Copyright © 2020 Kamil Gucik. All rights reserved.
//

import XCTest
@testable import Good_Weather

class SettingsViewModelTest: XCTestCase {
    
    private var settingsVM: SettingsViewModel!
    
    override func setUp() {
        super.setUp()
        
        self.settingsVM = SettingsViewModel()
    }
    
    func test_should_return_correct_display_name_for_celsius() {
        
        XCTAssertEqual(self.settingsVM.selectedUnit.displayName, "Celsius")
    }

    func test_should_make_sure_that_default_selected_unit_is_fahrenheit() {
        
        XCTAssertEqual(settingsVM.selectedUnit, .celsius)
    }
    
    func test_should_be_able_to_save_user_unit_selection() {
        
        self.settingsVM.selectedUnit = .fahrenheit
        let userDefaults = UserDefaults.standard
        XCTAssertNotNil(userDefaults.value(forKey: "unit"))
    }
    
    override class func tearDown() {
        super.tearDown()
        
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: "unit")
    }

}
