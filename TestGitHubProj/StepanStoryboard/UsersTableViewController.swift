//
//  UsersTableViewController.swift
//  TestGitHubProj
//
//  Created by Stepan Niemykin on 05.10.2020.
//

import UIKit

class UsersTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        self.title = "Users"
        
        tableView.register(UINib(nibName: "UsersTableViewCell", bundle: nil), forCellReuseIdentifier: "reuse")
    }
    
    var users = [User(name: "Valera", age: 20, count: 1000), User(name: "Step", age: 30, count: 12), User(name: "Sveta", age: 25, count: 123124)]
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        title = "USERS"
        return title
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuse", for: indexPath) as! UsersTableViewCell
        
        cell.countLabel.text = "\(users[indexPath.row].count)"
        cell.ageLabel.text = "\(users[indexPath.row].age)"
        cell.nameLabel.text = users[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Hello \(users[indexPath.row].name)")
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
