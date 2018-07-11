//
//  NodeInfoViewCell.swift
//  ManagerNodeApp
//
//  Created by Josip Glasovac on 11/06/2018.
//  Copyright © 2018 Josip Glasovac. All rights reserved.
//

import UIKit

class NodeInfoViewCell: UITableViewCell {
    
   // @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var connectorsLabel: UILabel!
    
    func setup(withNodeInfo nodeInfo: NodeInfo) {
        nameLabel.text = nodeInfo.name
        connectorsLabel.text = nodeInfo.connectors
        }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        connectorsLabel.text = ""
        nameLabel.text = ""
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.font = UIFont.systemFont(ofSize: 22)
        nameLabel.textColor = UIColor.brown
        connectorsLabel.font = UIFont.systemFont(ofSize: 22)
        connectorsLabel.textColor = UIColor.brown
        connectorsLabel.numberOfLines = 0
        // Initialization code
    }
}
