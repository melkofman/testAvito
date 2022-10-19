//
//  Graph.swift
//  avito
//
//  Created by Melanie Kofman on 17.10.2022.
//

import Foundation
class Graph {
    let viewController: ViewController
    private let dataSource: DataSource
    init() {
        dataSource = DataSource()
        viewController = ViewController(refreshAction: dataSource.setUpUpdate)
        dataSource.setOnUpdate { [unowned self] in
            self.viewController.model = $0
            DispatchQueue.main.async {
                self.viewController.tableView.reloadData()
            }
        }
        dataSource.showToast{ [unowned self] in
            let message = $0
            DispatchQueue.main.async {
            self.viewController.showMessageToas(message: message)
            }
        }
//        setUpUpdate()
    }
    
    func setUpUpdate() {
        dataSource.setUpUpdate()
    }
}
