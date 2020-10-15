//
//  ImageCell.swift
//  TestGitHubProj
//
//  Created by Anastasiia Spiridonova on 09.10.2020.
//

import UIKit

protocol ImageCellDelegate: AnyObject {
    func imageCell()
}

class ImageCell: UITableViewCell {
    
    weak var delegate: ImageCellDelegate?
    
    @IBOutlet weak var imagePlaceholder: UIImageView!
    
    @IBOutlet weak var bucketButton: UIButton!
    
    @IBAction func bucketButtonPressed() {
        delegate?.imageCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imagePlaceholder.image = UIImage(named: "userPhotoTemplate")
        bucketButton.isEnabled = false
        print("reload data")
    }
    
    func configure(with user: User) {
        DispatchQueue.main.async {
            FirebaseService.downloadUserImageFromDB(id: user.documentID) { [weak self] (image) in
                self?.imagePlaceholder.image = image
                self?.bucketButton.isEnabled = true
            }
        }
        if imagePlaceholder.image == nil {
            bucketButton.isEnabled = false
            imagePlaceholder.image = UIImage(named: "userPhotoTemplate")
        }
    }
}
