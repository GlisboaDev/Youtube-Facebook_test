//
//  User.swift
//  TestMusic
//
//  Created by Guilherme Lisboa on 09/04/17.
//  Copyright © 2017 LDevelopment. All rights reserved.
//

import Foundation

struct User {
    let accessToken: String
    
    init(accessToken: String) {
        self.accessToken = accessToken
    }
}
