//
//  ImageViewController.swift
//  TestGitHubProj
//
//  Created by Viacheslav Markov on 29.09.2020.
//

import UIKit

class ImageViewController: UIViewController {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var closedButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        closedButton.isHidden = true


    }
    
    @IBAction func touchClosedButton(_ sender: UIButton) {
    }
    
}
