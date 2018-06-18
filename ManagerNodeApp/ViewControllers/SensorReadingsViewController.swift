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

    @IBOutlet weak var titleLabel: UILabel!
    
    var refreshControl: UIRefreshControl!
    
    var viewModel: SensorReadingsViewModel!
 
    
   convenience init(viewModel: SensorReadingsViewModel){
    self.init()
    self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchAllSensorReadings { [weak self] (nodeInfos) in
                self?.titleLabel.text
            }
       // titleLabel.text  = viewModel.sensorReadingsLis[1] as? String
        
//        refreshControl = UIRefreshControl()
//        refreshControl.addTarget(self, action: #selector(SensorReadingsViewController.refresh), for: UIControlEvents.valueChanged)

        // Do any additional setup after loading the view.
    }
}

