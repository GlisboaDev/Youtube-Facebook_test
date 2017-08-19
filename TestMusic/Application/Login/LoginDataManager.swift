//
//  LoginDataManager.swift
//  TestMusic
//
//  Created by Guilherme Lisboa on 09/04/17.
//  Copyright © 2017 LDevelopment. All rights reserved.
//

import Foundation
import FacebookLogin
import FacebookCore
import RxSwift

protocol LoginManager {
    func loginUserOn(controller: UIViewController) -> Observable<User>
}

private let kUserLoginPermissions: [ReadPermission] = [.publicProfile, .custom("user_likes") ]

struct LoginDataManager: LoginManager {
    
    let userManager: UserManager
    
    init(userManager: UserManager) {
        self.userManager = userManager
    }
    
    func loginUserOn(controller: UIViewController) -> Observable<User> {
        return Observable.create({ (observer) -> Disposable in
            let loginManager = FacebookLogin.LoginManager()
            loginManager.logIn(kUserLoginPermissions, viewController: controller) { loginResult in
                switch loginResult {
                case .failed(let error):
                    observer.onError(error)
                case .cancelled:
                    observer.onError(AppError.loginFailed)
                case .success(_, _, let accessToken):
                    let user = User(accessToken: accessToken.authenticationToken)
                    self.userManager.saveUser(user: user)
                    observer.onNext(user)
                }
            }

            return Disposables.create()
        })
    }
}
