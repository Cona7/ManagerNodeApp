//
//  NodeInfo.swift
//  ManagerNodeApp
//
//  Created by Josip Glasovac on 11/06/2018.
//  Copyright © 2018 Josip Glasovac. All rights reserved.
//

import Foundation

class NodeInfo{
    
    var name: String?
    var connectors: String?
        
    init(name: String,connectors: String){
            
            self.name = name
            self.connectors = connectors
        }
    
    func getName() -> String{
        return name!
    }
}
