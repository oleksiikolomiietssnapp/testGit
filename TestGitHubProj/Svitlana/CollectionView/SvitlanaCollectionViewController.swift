//
//  SvitlanaCollectionViewController.swift
//  TestGitHubProj
//
//  Created by Svitlana Korostelova on 25.10.2020.
//

import UIKit

class SvitlanaCollectionViewController: UIViewController {
    var images = [UIImage]()
    let countCells = 2
    let offset: CGFloat = 2.0
    let cellId = "cell"

    @IBOutlet weak var collectionView: UICollectionView!
    
    override  func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        for i in 0...15 {
            guard let image = UIImage(named: "image\(i)") else {return}
            images.append(image)
        }
        collectionView.register(UINib(nibName: "SvitlanaCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellId)
    }
    
}

extension SvitlanaCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? SvitlanaCollectionViewCell else { return UICollectionViewCell() }
        let image = images[indexPath.item]
        cell.photoView.image = image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameCV = collectionView.frame
        let widthCell = frameCV.width / CGFloat(countCells)
        let heightCell = widthCell
        let spacing = CGFloat((countCells + 1)) * offset / CGFloat(countCells)
        return CGSize(width: widthCell - spacing, height: heightCell - (offset*2))
    }
}
