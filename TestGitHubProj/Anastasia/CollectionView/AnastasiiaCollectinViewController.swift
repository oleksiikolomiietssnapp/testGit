//
//  AnastasiiaCollectinViewController.swift
//  TestGitHubProj
//
//  Created by Anastasiia Spiridonova on 27.10.2020.
//

import UIKit

class AnastasiiaCollectinViewController: UIViewController {
    var isAbleToSelect = false
    let imageCount = 50
    var images = [AnastasiiaImage]()
    
    lazy var deleteBtn = { return UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteBtnPressed))}()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        images = (0..<imageCount).map { return AnastasiiaImage(name: "icon\($0 + 1)") }
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "AnastasiiaCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AnastasiiaCollectionViewCell")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Select", style: .plain, target: self, action: #selector(selectBtnPressed))
        setToolbarItems([UIBarButtonItem(systemItem: .flexibleSpace), deleteBtn], animated: true)
    }
    
    @objc func selectBtnPressed() {
        images.forEach { im in
            im.selected = false
        }
        deleteBtn.isEnabled = false
        self.isAbleToSelect.toggle()
        let title = navigationItem.rightBarButtonItem?.title
        if title == "Select" {
            navigationItem.rightBarButtonItem?.title = "Close"
            navigationController?.setToolbarHidden(false, animated: false)
        } else {
            navigationItem.rightBarButtonItem?.title = "Select"
            navigationController?.setToolbarHidden(true, animated: false)
        }
        collectionView.reloadData()
    }
    
    @objc func deleteBtnPressed() {
        images = images.filter { !$0.selected }
        collectionView.reloadData()
        selectBtnPressed()
    }
}

extension AnastasiiaCollectinViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnastasiiaCollectionViewCell", for: indexPath) as? AnastasiiaCollectionViewCell else {
            return UICollectionViewCell()
        }
        let cellMaxWidth = view.safeAreaLayoutGuide.layoutFrame.width / 3 - 16
        let image = images[indexPath.row]
        cell.frame.size.width = cellMaxWidth < 120 ? cellMaxWidth : 120
        cell.frame.size.height = cell.frame.width
        cell.imageView.image = UIImage(named: image.name)
        if isAbleToSelect {
            cell.imageView.alpha = image.selected ? 1 : 0.5
            cell.indicator.isHidden = !image.selected
        } else {
            cell.indicator.isHidden = true
            cell.imageView.alpha = 1
        }
        return cell
    }
}

extension AnastasiiaCollectinViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isAbleToSelect {
            let image = images[indexPath.row]
            image.selected.toggle()
            collectionView.reloadData()
        }
        var deleteIsEnabled = false
        for im in images where im.selected {
            deleteIsEnabled = true
            break
        }
        deleteBtn.isEnabled = deleteIsEnabled
    }
}
