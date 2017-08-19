//
//  RootRouter.swift
//  TestMusic
//
//  Created by Guilherme Lisboa on 09/04/17.
//  Copyright © 2017 LDevelopment. All rights reserved.
//

import UIKit

class RootRouter: Router {
    
    private var initialRouter = Router()
    private (set) lazy var initialController: UIViewController = {
        return UINavigationController(rootViewController: self.initialRouter.controller)
    }()
    
    override init() {
        super.init()
        setup()
    }
    
    func setup() {
        initialRouter = LoginRouter(parent: self)
    }
}
