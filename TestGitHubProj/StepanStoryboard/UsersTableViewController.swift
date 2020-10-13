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
        tableView.setEditing(true, animated: true)
        
        getUsers()
    }
    
    var users = [User(name: "Valera", age: 20, count: 1000), User(name: "Step", age: 30, count: 12), User(name: "Sveta", age: 25, count: 123124), User(name: "Shaban", age: 98, count: 1000), User(name: "Poroshenko", age: 12, count: 12), User(name: "Inokentiy", age: 115, count: 123124)]
    
    func getUsers() {
        FirebaseService.readUsersFromDB { users in
            let usersFromDB = users
            print(usersFromDB)
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        title = "USERS"
        return title
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuse", for: indexPath) as? UsersTableViewCell else { return UITableViewCell() }
        
        let user = users[indexPath.row]
        cell.setLabels(for: user)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Hello \(users[indexPath.row].name)")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.none
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {

        let movedElement = users[sourceIndexPath.row]

        //if source goes from top, else - source goes from bottom
        if destinationIndexPath.row > sourceIndexPath.row {
            for index in sourceIndexPath.row..<destinationIndexPath.row {
                users[index] = users[index + 1]
            }
        } else {
            for index in ((destinationIndexPath.row + 1)...sourceIndexPath.row).reversed() {
                users[index] = users[index - 1]
            }
        }

        users[destinationIndexPath.row] = movedElement

        tableView.reloadData()
    }
}
