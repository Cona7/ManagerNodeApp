//
//  ListOfNodesHeader.swift
//  ManagerNodeApp
//
//  Created by Josip Glasovac on 17/06/2018.
//  Copyright © 2018 Josip Glasovac. All rights reserved.
//

import UIKit
import PureLayout

class ListOfNodesHeader: UIView{
    
var titleLabel: UILabel!

override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = UIColor.purple
    titleLabel = UILabel()
    titleLabel.text = "List of Nodes"
    titleLabel.font = UIFont.systemFont(ofSize: 20)
    titleLabel.textColor = UIColor.white
    self.addSubview(titleLabel)
    titleLabel.autoPinEdge(.top, to: .top, of: self, withOffset: 16.0)
    titleLabel.autoAlignAxis(.vertical, toSameAxisOf: self)
}

required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
    }
}
