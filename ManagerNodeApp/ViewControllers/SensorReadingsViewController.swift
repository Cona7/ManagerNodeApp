//
//  SensorReadingsViewController.swift
//  ManagerNodeApp
//
//  Created by Josip Glasovac on 18/06/2018.
//  Copyright © 2018 Josip Glasovac. All rights reserved.
//

import UIKit
import Alamofire
import Charts

class SensorReadingsViewController: UIViewController {
    
    @IBOutlet weak var changeConnector: UIButton!
    @IBOutlet weak var lineChart: LineChartView!
    
    var refreshControl: UIRefreshControl!
    
    var viewModel: SensorReadingsViewModel!
    
    var sensorReadings: [Sensor] = []
    
   convenience init(viewModel: SensorReadingsViewModel){
    self.init()
    self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        viewModel.fetchAllSensorReadings { [weak self] (nodeInfos) in
            self?.setChartValues(nodeInfos: nodeInfos!)
        }
    }
    
    func setChartValues(nodeInfos: [Sensor] = []){
        let values = (0..<nodeInfos.count).map { (i) -> ChartDataEntry in
            let val = Double(nodeInfos[i].value!)

            let removal: [Character] = [":"," ", "-"]
            let unfilteredCharacters = nodeInfos[i].date?.characters
            let filteredCharacters = unfilteredCharacters?.filter { !removal.contains($0) }
            let filtered = String(filteredCharacters!)

            return ChartDataEntry(x: Double(i), y: val)
        }
        let set1 = LineChartDataSet(values: values, label: "Sensor temperature values in: " + nodeInfos[1].unit!)
        let data = LineChartData(dataSet: set1)
        
        self.lineChart.data = data
    }
    
    @IBAction func changeConnector(_ sender: Any) {
        
        viewModel.fetchAllSensorReadings { [weak self] (nodeInfos) in
            self?.setChartValues(nodeInfos: nodeInfos!)
        }
}
}
