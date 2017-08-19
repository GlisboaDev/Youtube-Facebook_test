//
//  LoginRouter.swift
//  TestMusic
//
//  Created by Guilherme Lisboa on 09/04/17.
//  Copyright © 2017 LDevelopment. All rights reserved.
//

import Foundation

class MainScreenRouter: Router {
    override init(parent: Router) {
        super.init(parent: parent)
        let dataManager = MainScreenDataManager()
        self.controller = MainScreenController(router: self, dataManager: dataManager)
    }
}
