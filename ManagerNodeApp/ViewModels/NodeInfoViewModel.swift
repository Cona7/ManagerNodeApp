//
//  NodeInfoViewModel.swift
//  ManagerNodeApp
//
//  Created by Josip Glasovac on 11/06/2018.
//  Copyright © 2018 Josip Glasovac. All rights reserved.
//

import Foundation
import Alamofire

class NodeInfoViewModel {
    
    var nodeInfoList: [NodeInfo] = []
    
    let url = "http://10.19.4.127:8080/nodeRegister"
    
    func fetchAllNodes(completion: @escaping ([NodeInfo]?) -> Void) {
        guard let url = URL(string: url) else {
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
                    self.nodeInfoList.append( NodeInfo(name: (elem["name"] as? String)!,
                                                       connectors: (elem["connectors"] as? String)!))
                }
                completion(self.nodeInfoList) 
        }
    }
    
    func nodeInfo(atIndex index: Int) -> NodeInfo? {
        return nodeInfoList[index]
    }
    
    func numberOfNodeInfos() -> Int {
        print(nodeInfoList.count)
        return nodeInfoList.count }
}

