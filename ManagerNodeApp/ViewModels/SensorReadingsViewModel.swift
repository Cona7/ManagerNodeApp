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
        
        
        var connectors = nodeInfo.connectors
        let removal: [Character] = [" "]
        let unfilteredCharacters = connectors?.characters
        let filteredCharacters = unfilteredCharacters?.filter { !removal.contains($0) }
        let filteredConnectors = String(filteredCharacters!)
        var con1 = filteredConnectors.split(separator: ",")[0]
        
        let timeNow = generateTime(delay: 0)
        let timeBeforeFiveMinutes = generateTime(delay: -300)
        
        let urlBase = "http://10.19.4.127:8080/client/" + nodeInfo.getName() + "/" + con1 + "/" + timeBeforeFiveMinutes + "/" + timeNow
        
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
    
    func generateTime(delay: Int) -> String {
        
        let removal: [Character] = [":"," ", "-"]
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let myString = formatter.string(from: Date().addingTimeInterval(TimeInterval(delay)))
        let yourDate = formatter.date(from: myString)
        
        formatter.dateFormat = "yyy-MM-dd HH:mm:ss"
        let myStringafd = formatter.string(from: yourDate!)
        
        let unfilteredCharacters = myStringafd.characters
        let filteredCharacters = unfilteredCharacters.filter { !removal.contains($0) }
        let filtered = String(filteredCharacters)
        
        return filtered
    }
    
}
