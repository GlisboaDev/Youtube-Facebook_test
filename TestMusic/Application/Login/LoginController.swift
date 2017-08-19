//
//  LoginController.swift
//  TestMusic
//
//  Created by Guilherme Lisboa on 09/04/17.
//  Copyright © 2017 LDevelopment. All rights reserved.
//

import UIKit
import FacebookCore
import RxSwift
import RxCocoa
import SnapKit

class LoginController : Controller {
    
    private let loginView = LoginView()
    private let dataManager: LoginManager
    
    init(router: Router, dataManager: LoginManager) {
        self.dataManager = dataManager
        super.init(router: router)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeUI()
        createConstraints()
    }
    
    private func initializeUI() {
        loginView.loginButton.rx.tap
            .flatMap { [weak self] () -> Observable<User> in
                guard let `self` = self else {return Observable.error(AppError.deallocated)}
                
                return self.dataManager.loginUserOn(controller: self)
            }.subscribe(onNext: {[weak self] (user) in
                self?.router.navigateTo(destination: .main, data: user)
                }, onError: { [weak self] (error) in
                    self?.showError(message: "\(error.localizedDescription)")
            }).addDisposableTo(disposeBag)
        
        view.addSubview(loginView)
    }
    
    private func createConstraints() {
        loginView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    private func showError(message: String) {
        
        let allertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        allertController.show(self, sender: nil)
        
    }
    
}
