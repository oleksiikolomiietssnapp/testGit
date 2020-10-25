//
//  SvitlanaCollectionViewCell.swift
//  TestGitHubProj
//
//  Created by Svitlana Korostelova on 25.10.2020.
//

import UIKit

class SvitlanaCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var select: UIImageView!
    @IBOutlet weak var photoView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        select.isHidden = true
    }

}
