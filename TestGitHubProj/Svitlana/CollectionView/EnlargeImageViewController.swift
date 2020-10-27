//
//  EnlargeImageViewController.swift
//  TestGitHubProj
//
//  Created by Svitlana Korostelova on 27.10.2020.
//

import UIKit

class EnlargeImageViewController: UIViewController {
    @IBOutlet weak var enlargeImage: UIImageView!
    var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        enlargeImage.image = image
    }
}
