//
//  ListOfNodesViewController.swift
//  ManagerNodeApp
//
//  Created by Josip Glasovac on 11/06/2018.
//  Copyright © 2018 Josip Glasovac. All rights reserved.
//

import UIKit
import Alamofire
import CoreGraphics

class ListOfNodesViewController: UIViewController {
    
    var viewModel: NodeInfoViewModel!
    
    var refreshControl: UIRefreshControl!
    
    let cellReuseIdentifier = "cellReuseIdentifier"

    @IBOutlet weak var tableView: UITableView!
    
    convenience init(viewModel: NodeInfoViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        setupTableView()
//        tableView.reloadData()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       setupData()
       setupTableView()
         tableView.tableFooterView = UIView()
       //tableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    func setupTableView() {
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ListOfNodesViewController.refresh), for: UIControlEvents.valueChanged)
        tableView.refreshControl = refreshControl
        
        tableView.register(UINib(nibName: "NodeInfoViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    func setupData() {
        viewModel.fetchAllNodes { [weak self] (nodeInfoList) in
            self?.refresh()
        }
    }
    
    @objc func refresh() {
        
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
}

extension ListOfNodesViewController: UITableViewDelegate {
    
    //ograničava da svi filmovi, odnosno redovi budu jednakih proporcija, slike
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    //postavi View klasu header za header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = ListOfNodesHeader()
        return view
    }
    
    //dodjeli mu visinu
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 52.0
    }
    
    //na temelju rowa, indexa editaj
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let cellNodeInfo = viewModel.nodeInfo(atIndex: indexPath.row) {
            let sensorReadingsViewModel = SensorReadingsViewModel(nodeInfo: cellNodeInfo)
            let sensorReadingsViewController = SensorReadingsViewController(viewModel: sensorReadingsViewModel)
            self.navigationController?.pushViewController(sensorReadingsViewController, animated: true)
        }
        self.refresh()
    }
}

extension ListOfNodesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! NodeInfoViewCell

        if let nodeInfo = viewModel.nodeInfo(atIndex: indexPath.row) {
            cell.setup(withNodeInfo: nodeInfo)
        }
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: cell.bounds.size.width, right: 0)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel.nodeInfoList.count)
        return viewModel.nodeInfoList.count
    }
}

