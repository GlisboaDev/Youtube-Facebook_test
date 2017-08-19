//
//  LoginRouter.swift
//  TestMusic
//
//  Created by Guilherme Lisboa on 09/04/17.
//  Copyright © 2017 LDevelopment. All rights reserved.
//

import Foundation

class LoginRouter: Router {
    override init(parent: Router) {
        super.init(parent: parent)
        let loginDataManager = LoginDataManager(userManager: AppUserManager.shared)
        self.controller = LoginController(router: self, dataManager: loginDataManager)
    }
    
    override func destinationRouterForPath(path: NavigationPath, data: Any?) -> Router? {
        switch path {
        case .main:
            return MainScreenRouter(parent: self)
        default:
            return nil
        }
    }
}
