//
//  ImageListViewController.swift
//  TestGitHubProj
//
//  Created by Viacheslav Markov on 05.10.2020.
//

import UIKit

class ImageListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var listImages: ListImages = ListImages()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "ImageTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageTableViewCell")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }

}

extension ImageListViewController: UITableViewDelegate {
    
}

extension ImageListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listImages.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell", for: indexPath) as? ImageTableViewCell
        let list = listImages.list[indexPath.item]
        cell?.setupCell(list: list)
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.width / 4
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "ShowImageStoryboard", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "ShowImageViewController") as? ShowImageViewController else { return }
        vc.image = listImages.list[indexPath.row].image
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
