//
//  SensorReadingsViewModel.swift
//  ManagerNodeApp
//
//  Created by Josip Glasovac on 18/06/2018.
//  Copyright © 2018 Josip Glasovac. All rights reserved.
//

import Foundation
import Alamofire

class SensorReadingsViewModel{
    
    var nodeInfo: NodeInfo!
    
     var sensorReadingsList: [Sensor] = []
    
    convenience init(nodeInfo: NodeInfo){
        self.init()
        self.nodeInfo = nodeInfo
    }
    
    func fetchAllSensorReadings(completion: @escaping ([Sensor]?) -> Void) {
        
        let urlBase = "http://10.19.4.127:8080/client/" + nodeInfo.getName() + "/sensor_temp/20180618131000"
        
        guard let url = URL(string: urlBase) else {
            completion(nil)
            return
        }
        
        Alamofire.request(url,
                          method: .get)
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    completion(nil)
                    return
                }
                
                let value = response.result.value as? [[String: Any]]
                for elem in value!{
                    self.sensorReadingsList.append( Sensor(name: (elem["name"] as? String)!,
                                                           date: (elem["date"] as? String)!,
                                                           value: (elem["value"] as? Int)!,
                                                           unit: (elem["unit"] as? String)!))
                }
                completion(self.sensorReadingsList)
                print (self.sensorReadingsList.count)
        }
    }
}
