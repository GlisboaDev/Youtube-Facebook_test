//
//  LoginView.swift
//  TestMusic
//
//  Created by Guilherme Lisboa on 09/04/17.
//  Copyright © 2017 LDevelopment. All rights reserved.
//

import UIKit
import SnapKit
import FacebookCore

class MainScreenView: UIView {
    
    let tableView = UITableView()
    
    init() {
        super.init(frame: CGRect.zero)
        initializeUI()
        createConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initializeUI() {
        backgroundColor = UIColor.red
        addSubview(tableView)
    }
    
    private func createConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
}
