//
//  WeatherListTableViewController.swift
//  Good Weather
//
//  Created by Kamil Gucik on 05/05/2020.
//  Copyright © 2020 Kamil Gucik. All rights reserved.
//

import Foundation
import UIKit

class WeatherListTableViewController: UITableViewController, AddWeatherDelegate, SettingsDelegate {
    
    
    func settingsDone(vm: SettingsViewModel) {
        self.weatherListViewModel.updateUnit(to: vm.selectedUnit)
        self.tableView.reloadData()
    }
    
    
    private var weatherListViewModel = WeatherListViewModel()
    private var dataSource: TableViewDataSource<WeatherCell,WeatherViewModel>!
    
    func addWeatherDidSave(vm: WeatherViewModel) {
        self.weatherListViewModel.addWeatherViewModel(vm)
        self.dataSource.updateItems(self.weatherListViewModel.weatherViewModels)
        self.tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.dataSource = TableViewDataSource(cellIdentifier: "WeatherCell", items: self.weatherListViewModel.weatherViewModels) { cell, vm in
            
            cell.cityNameLabel.text = vm.name.value
            cell.temperatureLabel.text = vm.currentTemperature.temperature.value.formatAsDegree
        }
        self.tableView.dataSource = self.dataSource
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "AddCityWeatherViewController" {
            
            prepareForSegueAddWeatherCityViewController(segue: segue)
            
        } else if segue.identifier == "SettingsTableViewController" {
            
            prepareSegueForSettings(segue: segue)
        } else if segue.identifier == "WeatherDetailsViewController" {
            
            prepareSegueForWeatherDetailsViewController(segue: segue)
        }
        
    }
    
    private func prepareSegueForWeatherDetailsViewController(segue: UIStoryboardSegue) {
        
        guard let weatherDetailsVC = segue.destination as? WeatherDetailsViewController, let indexPath = self.tableView.indexPathForSelectedRow else {
            return
        }
        
        let weatherVM = self.weatherListViewModel.modelAt(indexPath.row)
        weatherDetailsVC.weatherViewModel = weatherVM
    }
    
    private func prepareSegueForSettings(segue: UIStoryboardSegue) {
        
        guard let nav = segue.destination as? UINavigationController else {
                   fatalError("Nav contr not found")
               }
               
               guard let settingsTVC = nav.viewControllers.first as? SettingsTableViewController else {
                   fatalError("SettingsTVC not found")
               }
               
               settingsTVC.delegate = self
    }
    
    private func prepareForSegueAddWeatherCityViewController(segue: UIStoryboardSegue) {
        
        guard let nav = segue.destination as? UINavigationController else {
            fatalError("Nav contr not found")
        }
        
        guard let addWeatherCityVC = nav.viewControllers.first as? AddWeatherCityViewController else {
            fatalError("AddWeatherCityController not found")
        }
        
        addWeatherCityVC.delegate = self
        
    }
    
}

