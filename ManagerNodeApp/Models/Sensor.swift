//
//  Sensor.swift
//  ManagerNodeApp
//
//  Created by Josip Glasovac on 18/06/2018.
//  Copyright © 2018 Josip Glasovac. All rights reserved.
//

import Foundation

class Sensor {
    
    var name: String?
    var date: String?
    var value: Int?
    var unit: String?
    
    init(name: String,date: String, value: Int, unit: String){
        self.name = name
        self.date = date
        self.value = value
        self.unit = unit
    }
}
