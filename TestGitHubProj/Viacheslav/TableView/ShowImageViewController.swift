//
//  ShowImageViewController.swift
//  TestGitHubProj
//
//  Created by Viacheslav Markov on 06.10.2020.
//

import UIKit

class ShowImageViewController: UIViewController {
    
    var image: UIImage?
    
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = image
    }

}
