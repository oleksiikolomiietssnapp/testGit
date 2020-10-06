//
//  RequestViewController.swift
//  TestGitHubProj
//
//  Created by Anastasiia Spiridonova on 05.10.2020.
//

import UIKit

class RequestViewController: UIViewController {
    let tableView = UITableView()
    let navBar = UINavigationBar()
    var users: [User]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(navBar)
        view.addSubview(tableView)
        tableView.frame = view.safeAreaLayoutGuide.layoutFrame
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        self.tableView.dataSource = self
        view.backgroundColor = UIColor.systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.safeAreaLayoutGuide.layoutFrame
        
    }
}
extension RequestViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let users = users else {
        print("tableView")
        return 0
    }
    return users.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
    guard let textLabel = cell.textLabel, let users = users else {
        return cell
    }
    textLabel.text = users[indexPath.row].name
    cell.accessoryType = .disclosureIndicator
    return cell
  }
}
