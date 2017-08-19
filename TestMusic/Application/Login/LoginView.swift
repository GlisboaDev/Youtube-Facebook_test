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

class LoginView: UIView {
    
    let loginButton = UIButton(type: .custom)

    init() {
        super.init(frame: CGRect.zero)
        initializeUI()
        createConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initializeUI() {
        backgroundColor = UIColor.white
        loginButton.backgroundColor = UIColor.blue
        loginButton.setTitle("My Login Button", for: .normal)
        addSubview(loginButton)
    }
    
    private func createConstraints() {
        loginButton.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.height.equalTo(50)
            make.width.equalTo(180)
        }
    }
}
