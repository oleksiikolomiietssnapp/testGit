//
//  ImageListViewController.swift
//  TestGitHubProj
//
//  Created by Viacheslav Markov on 05.10.2020.
//

import UIKit

class ImageListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var listImages: ListImages = ListImages()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }

}

extension ImageListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listImages.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        let list = listImages.list[indexPath.item]
        cell.setupCell(list: list)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = UIScreen.main.bounds.width
        return CGSize(width: size, height: size / 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func goToViewPhoto() {
        let storybord = UIStoryboard(name: "ShowImageStoryboard", bundle: nil)
        guard let vc = storybord.instantiateViewController(identifier: "ShowImageViewController") as? ShowImageViewController else { return }
        navigationController?.pushViewController(vc, animated: true)
    }

}
