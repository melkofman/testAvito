//
//  ViewController.swift
//  avito
//
//  Created by Melanie Kofman on 17.10.2022.
//

import UIKit
import Reachability
class ViewController: UIViewController {
    var model: DataList?
    var tableView: UITableView!
    
    private let refreshAction: () -> Void
    private let refreshControl = UIRefreshControl()
    
    private let sizingCell = TableCell()
    
    let reachability = try! Reachability()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
            do{
              try reachability.startNotifier()
            }catch{
              print("could not start reachability notifier")
            }
    }
    
    @objc
    func reachabilityChanged(note: Notification) {

      let reachability = note.object as! Reachability
        
        if reachability.connection == .unavailable {
            showMessageToast(message: "Че-то с сетью")
        }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
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
        self.refreshControl.endRefreshing()
    }
    
    func showMessageToast(message:String) {
        showToast(message: message, font: .systemFont(ofSize: Brandbook.TextSize.tiny))
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
        return UITableView.automaticDimension
    }
    
    func tableView(tableView: UITableView,
        heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.reusedId, for: indexPath) as! TableCell
        cell.clear()
        cell.labelName.text = model?.company.employees[indexPath.row].name
        cell.labelTel.text = model?.company.employees[indexPath.row].phone_number
        if let skills = model?.company.employees[indexPath.row].skills {
            cell.setSkillsLabels(skills: skills)
        }
        return cell
    }
}

extension UIViewController {
    
    func showToast(message : String, font: UIFont) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75,
                                               y: self.view.frame.size.height-100,
                                               width: 150, height: 35))
        toastLabel.backgroundColor = Brandbook.Colors.black_alpha
        toastLabel.textColor = Brandbook.Colors.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = Brandbook.CornerRadius.normal;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 8.0, delay: 0.2, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
}
