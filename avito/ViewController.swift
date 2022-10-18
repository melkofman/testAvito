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
    
    private let refreshAction: () -> Void
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    init(refreshAction: @escaping () -> Void) {
        self.refreshAction = refreshAction
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        self.view.backgroundColor = Brandbook.Colors.white
        tableView = UITableView(frame: .zero, style: UITableView.Style.plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        tableView?.topAnchor.constraint(equalTo: self.view.topAnchor, constant: Brandbook.Padding.big).isActive = true
        tableView?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView?.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView?.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        tableView?.register(TableCell.self, forCellReuseIdentifier: TableCell.reusedId)
        tableView?.backgroundColor = Brandbook.Colors.white
        
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
    }
    
    @objc
    private func refresh(_ sender: Any) {
        refreshAction()
        tableView.reloadData()
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
        return Brandbook.Height.section
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Brandbook.Height.row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.reusedId, for: indexPath) as! TableCell
        cell.labelName.text = model?.company.employees[indexPath.row].name
        cell.labelTel.text = model?.company.employees[indexPath.row].phone_number
        if let skills = model?.company.employees[indexPath.row].skills {
            cell.setSkillsLabels(skills: skills)
        }
        return cell
    }
}

