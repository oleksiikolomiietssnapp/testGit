//
//  UserViewController.swift
//  TestGitHubProj
//
//  Created by Anastasiia Spiridonova on 08.10.2020.
//

import UIKit

class UserViewController: UIViewController {
    let user: User?
    lazy private var tableView = { return UITableView() }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        guard let user = user else {
            return
        }
        navigationItem.title = user.name
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "infoCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "imageCell")
        tableView.dataSource = self
    }
    
    override func viewWillLayoutSubviews() {
        tableView.frame = view.safeAreaLayoutGuide.layoutFrame
    }
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.user = nil
        super.init(coder: coder)
    }
}

extension UserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let user = user else {
            return 0
        }
        return Mirror(reflecting: user).children.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let user = user else {
            return UITableViewCell()
        }
        switch indexPath.row {
        case 0:
            return tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath)
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath)
            cell.textLabel?.text = "Age: " + String(user.age)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath)
            cell.textLabel?.text = "Count: " + String(user.count)
            return cell
        }
    }
}
