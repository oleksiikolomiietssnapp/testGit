//
//  FirebaseUsersViewController.swift
//  TestGitHubProj
//
//  Created by Anastasiia Spiridonova on 08.10.2020.
//

import UIKit

class FirebaseUsersViewController: UIViewController {
    let users: [User]
    lazy private var tableView = { return UITableView() }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame = view.safeAreaLayoutGuide.layoutFrame
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "userCell")
    }
    
    init(users: [User]) {
        self.users = users
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.users = []
        super.init(coder: coder)
    }
}

extension FirebaseUsersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        guard let textLabel = cell.textLabel else {
            return cell
        }
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        textLabel.text = users[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "UserInfoStoryboard", bundle: .main)
        guard let vc = storyboard.instantiateViewController(identifier: "userViewController") as? UserViewController else {
            print(storyboard.instantiateViewController(identifier: "userViewController"))
            return
        }
        vc.user = users[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
