//
//  SvitlanaCollectionViewCell.swift
//  TestGitHubProj
//
//  Created by Svitlana Korostelova on 25.10.2020.
//

import UIKit

class SvitlanaCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var checkboxView: UIImageView!
    @IBOutlet weak var photoView: UIImageView!

    func configure(image: UIImage, isSelectModeTapped: Bool) {
        self.photoView.image = image
        checkboxView.isHidden = !isSelectModeTapped
        if isSelectModeTapped {
            checkboxView.image = UIImage(named: "unchecked")
        }
    }
}
