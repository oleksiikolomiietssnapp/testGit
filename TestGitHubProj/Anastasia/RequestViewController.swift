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
        self.tableView.delegate = self
        view.backgroundColor = UIColor.systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.safeAreaLayoutGuide.layoutFrame
        
    }
}
extension RequestViewController: UITableViewDataSource, UITableViewDelegate {
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users![indexPath.item]
        
        let vc = UIViewController()
        vc.view.backgroundColor = .systemBackground
        let textView = UITextView(frame: CGRect(x: vc.view.safeAreaLayoutGuide.layoutFrame.minX + 16, y: vc.view.safeAreaLayoutGuide.layoutFrame.minY + 16, width: vc.view.safeAreaLayoutGuide.layoutFrame.width - 32, height: vc.view.safeAreaLayoutGuide.layoutFrame.height - 32))
        textView.isEditable = false
        
        let boldFont = UIFont.boldSystemFont(ofSize: 24)
        let boldFontAttribute = [NSAttributedString.Key.font : boldFont]
        let regularFont = UIFont.systemFont(ofSize: 24)
        let regularFontAttribute = [NSAttributedString.Key.font : regularFont]
        
        let text = NSMutableAttributedString()
        text.append(NSAttributedString(string: "Name: ", attributes: regularFontAttribute))
        text.append(NSAttributedString(string: "\(user.name)\n", attributes: boldFontAttribute))
        text.append(NSAttributedString(string: "Age: ", attributes: regularFontAttribute))
        text.append(NSAttributedString(string: "\(user.age)\n", attributes: boldFontAttribute))
        text.append(NSAttributedString(string: "Count: ", attributes: regularFontAttribute))
        text.append(NSAttributedString(string: "\(user.count)", attributes: boldFontAttribute))
        
        vc.view.addSubview(textView)
        textView.attributedText = text
        present(vc, animated: true, completion: nil)
    }
}
