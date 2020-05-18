//
//  TableViewDataSource.swift
//  Good Weather
//
//  Created by Kamil Gucik on 08/05/2020.
//  Copyright © 2020 Kamil Gucik. All rights reserved.
//

import Foundation
import UIKit

class TableViewDataSource <CellType,ViewModel>: NSObject, UITableViewDataSource where CellType: UITableViewCell {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? CellType else {
            fatalError("Cell with ID not found")
        }
        
        let vm = self.items[indexPath.row]
        self.configureCell(cell, vm)
        return cell
    }
    
    func updateItems(_ items: [ViewModel]) {
        self.items = items
    }
    
    
    let cellIdentifier: String
    var items: [ViewModel]
    let configureCell: (CellType,ViewModel) -> ()
    
    init(cellIdentifier: String, items: [ViewModel], configureCell: @escaping (CellType,ViewModel) -> ()) {
        
        self.cellIdentifier = cellIdentifier
        self.items = items
        self.configureCell = configureCell
    }
}
