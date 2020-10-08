//
//  ImageListViewController.swift
//  TestGitHubProj
//
//  Created by Viacheslav Markov on 05.10.2020.
//

import UIKit
//import Foundation

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
        //        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShowImageViewController", for: indexPath) as! ShowImageViewController
        //        let list = listImages.list[indexPath.item]
        //        cell.setupCell(list: list)
        //        return cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell", for: indexPath) as! ImageTableViewCell
        let list = listImages.list[indexPath.item]
        cell.setupCell(list: list)
        cell.imageView?.image = listImages.image
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.width / 4
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "ShowImageStoryboard", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ShowImageViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
//extension ImageListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return listImages.list.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShowImageViewController", for: indexPath) as! ShowImageViewController
//        let list = listImages.list[indexPath.item]
//        cell.setupCell(list: list)
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let size = UIScreen.main.bounds.width
//        return CGSize(width: size, height: size / 8)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 8
//    }
//
//    func goToViewPhoto() {
//        let storybord = UIStoryboard(name: "ShowImageStoryboard", bundle: nil)
//        guard let vc = storybord.instantiateViewController(identifier: "ShowImageViewController") as? ShowImageViewController else { return }
//        navigationController?.pushViewController(vc, animated: true)
//    }
//
//}
