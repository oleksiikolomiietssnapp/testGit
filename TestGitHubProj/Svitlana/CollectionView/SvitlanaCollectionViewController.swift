//
//  SvitlanaCollectionViewController.swift
//  TestGitHubProj
//
//  Created by Svitlana Korostelova on 25.10.2020.
//

import UIKit

class SvitlanaCollectionViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    var images = [UIImage]()
    let countCells = 6
    let offset: CGFloat = 2.0
    let cellId = "cell"
    var isSelectModeTapped = false
    var tappedImages = [Int]()
    let imagePicker = UIImagePickerController()
    
    @IBAction func addImage(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func deleteImage(_ sender: UIButton) {
        //        collectionView.deleteItems(at: tappedImages[IndexPath])
        let indexes = tappedImages.sorted()
        indexes.reversed().forEach { (index) in
            images.remove(at: index)
        }
        tappedImages = []
        collectionView.reloadData()
    }
    @IBOutlet weak var selectOrCancel: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func selectPhoto(_ sender: UIButton) {
        tappedImages = []
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
        imagePicker.delegate = self
        for i in 0...19 {
            guard let image = UIImage(named: "image\(i)") else {return}
            images.append(image)
        }
        collectionView.register(UINib(nibName: "SvitlanaCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellId)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            images.append(pickedImage)
            collectionView.reloadData()
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension SvitlanaCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? SvitlanaCollectionViewCell else { return UICollectionViewCell() }
        let image = images[indexPath.item]
        let imageWasTapped = tappedImages.contains(indexPath.row)
        cell.configure(image: image, isSelectModeTapped: isSelectModeTapped, isImageTapped: imageWasTapped)
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
        if isSelectModeTapped {
            tappedImages.append(indexPath.row)
            collectionView.reloadItems(at: [indexPath])
        } else {
            let storyboard = UIStoryboard(name: "SvitlanaCollectionView", bundle: nil)
            guard let vc = storyboard.instantiateViewController(identifier: "EnlargeImageViewController") as? EnlargeImageViewController else {
                print("error")
                return
            }
            vc.image = images[indexPath.row]
            self.navigationController?.present(vc, animated: true)
            
        }
    }
}
