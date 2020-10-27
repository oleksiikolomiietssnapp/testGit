//
//  CollectionViewCell.swift
//  TestGitHubProj
//
//  Created by Anastasiia Spiridonova on 27.10.2020.
//

import UIKit

class AnastasiiaCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var indicator: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        indicator.layer.borderWidth = 2
        indicator.layer.borderColor = UIColor.white.cgColor
        indicator.layer.cornerRadius = indicator.frame.width / 2
    }

    override func prepareForReuse() {
        imageView.image = nil
        indicator.isHidden = true
    }
}
