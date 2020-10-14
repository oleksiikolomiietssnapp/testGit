//
//  TableViewController.swift
//  TestGitHubProj
//
//  Created by Svitlana Korostelova on 09.10.2020.
//

import UIKit

class TableViewController: UITableViewController {
    var users: [User] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "UserTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "reuseIdentifier")

        FirebaseService.readUsersFromDB(callback: { [weak self] users in
            self?.users = users
        })

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "reuseIdentifier",
                for: indexPath) as? UserTableViewCell else {return UITableViewCell()}
        cell.configure(with: self.users[indexPath.row])

        return cell
    }
}
