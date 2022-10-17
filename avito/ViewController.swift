//
//  ViewController.swift
//  avito
//
//  Created by Melanie Kofman on 17.10.2022.
//

import UIKit

class ViewController: UIViewController {
    var model: DataList?
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp() {
        self.view.backgroundColor = .cyan
        tableView = UITableView(frame: .zero, style: UITableView.Style.plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        tableView?.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
        tableView?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView?.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView?.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        tableView?.register(TableCell.self, forCellReuseIdentifier: TableCell.reusedId)
        tableView?.backgroundColor = .brown
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.company.employees.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionTitle: String?
        sectionTitle = model?.company.name
        return sectionTitle
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.reusedId, for: indexPath) as! TableCell
        cell.label.text = model?.company.employees[indexPath.row].name
        cell.backgroundColor = .yellow
        return cell
    }
}

