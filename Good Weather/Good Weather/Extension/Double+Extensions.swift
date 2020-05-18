//
//  Double+Extensions.swift
//  Good Weather
//
//  Created by Kamil Gucik on 06/05/2020.
//  Copyright © 2020 Kamil Gucik. All rights reserved.
//

import Foundation

extension Double {
    
    var formatAsDegree : String {
        return String(format:"%.0f°",self)
    }
}
