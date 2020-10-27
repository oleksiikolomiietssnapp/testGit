//
//  SvitlanaCollectionViewController.swift
//  TestGitHubProj
//
//  Created by Svitlana Korostelova on 25.10.2020.
//

import UIKit

class SvitlanaCollectionViewController: UIViewController {
    var images = [UIImage]()
    let countCells = 3
    let offset: CGFloat = 2.0
    let cellId = "cell"
    var isSelectModeTapped = false
    var tappedImages = [UIImage]()
    
    @IBOutlet weak var selectOrCancel: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func selectPhoto(_ sender: UIButton) {
        isSelectModeTapped = !isSelectModeTapped
        if isSelectModeTapped {
            selectOrCancel.setTitle("Cancel", for: .normal)
        } else {
            selectOrCancel.setTitle("Select", for: .normal)
        }
        collectionView.reloadData()
    }
     
    override  func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        for i in 0...19 {
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
        cell.configure(image: image, isSelectModeTapped: isSelectModeTapped)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameCV = collectionView.frame
        let widthCell = frameCV.width / CGFloat(countCells)
        let heightCell = widthCell
        let spacing = CGFloat((countCells + 1)) * offset / CGFloat(countCells)
        return CGSize(width: widthCell - spacing, height: heightCell - (offset*2))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = images[indexPath.item]
        tappedImages.append(image)
        print(tappedImages)
        //delete here
        //есть ли картинка в массиве булево передать в конфигур
    }
}
