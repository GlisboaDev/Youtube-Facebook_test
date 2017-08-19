//
//  UserManager.swift
//  TestMusic
//
//  Created by Guilherme Lisboa on 09/04/17.
//  Copyright © 2017 LDevelopment. All rights reserved.
//

import Foundation

protocol UserManager {
    var user: User {get}
    func saveUser(user: User)
}

class AppUserManager: UserManager {

    var user: User = User(accessToken: "")
    static let shared: UserManager = AppUserManager()

    func saveUser(user: User) {
        self.user = user
    }

}
