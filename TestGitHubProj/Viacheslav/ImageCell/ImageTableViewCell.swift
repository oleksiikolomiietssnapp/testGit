//
//  ImageTableViewCell.swift
//  TestGitHubProj
//
//  Created by Viacheslav Markov on 08.10.2020.
//

import UIKit
//import Foundation

class ImageTableViewCell: UITableViewCell {

    @IBOutlet var imageCellView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupCell(list: List) {
        self.imageCellView.image = list.image
        self.titleLabel.text = list.nameOfImage
    }
    
}
