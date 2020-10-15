//
//  UserViewController.swift
//  TestGitHubProj
//
//  Created by Anastasiia Spiridonova on 08.10.2020.
//

import UIKit

class UserViewController: UIViewController, ImageCellDelegate {
    
    var user: User?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layoutSubviews()
        view.backgroundColor = .systemBackground
        
        guard let user = user else {
            return
        }
        title = user.name
        tableView.dataSource = self
        let imageCellNib = UINib(nibName: "ImageCell", bundle: .main)
        tableView.register(imageCellNib, forCellReuseIdentifier: "imageCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "infoCell")
    }
}

extension UserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard user != nil else {
            return 0
        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let user = user else {
            return UITableViewCell()
        }
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as? ImageCell else { return UITableViewCell() }
            cell.delegate = self
            cell.configure(with: user)
            return cell
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
    
    func imageCell() {
        guard  let user = user else {
            return
        }
        FirebaseService.removeUserImageFromDB(id: user.documentID)
        tableView.reloadData()
    }
}
