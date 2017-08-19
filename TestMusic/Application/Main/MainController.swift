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
import Kingfisher

private let kCellReuseID = "Cell"

class MainScreenController: Controller {

    private let mainView = MainScreenView()
    private let dataManager: MainScreenManager

    init(router: Router, dataManager: MainScreenManager) {
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
        mainView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: kCellReuseID)
        
        tableViewBindings()
        view.addSubview(mainView)
    }
    
    private func tableViewBindings() {
        dataManager.playlists
            .bindTo(mainView.tableView.rx.items(cellIdentifier: kCellReuseID, cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = element.title
                
                cell.imageView?.kf.setImage(with: URL(string: element.imageUrl))
            }.addDisposableTo(disposeBag)
        mainView.tableView.rx.contentOffset.debounce(0.2, scheduler: MainScheduler.instance).subscribe(onNext: {[weak self] (offset) in
            guard let `self` = self else {return}
            if self.shouldLoadMoreData(offset: offset) {
                self.dataManager.loadUserPlaylists()
            }
        }).addDisposableTo(disposeBag)
    }
    
    private func shouldLoadMoreData(offset: CGPoint) -> Bool {
        return offset.y + mainView.tableView.frame.size.height + 20 > mainView.tableView.contentSize.height
    }

    private func createConstraints() {
        mainView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }

}
