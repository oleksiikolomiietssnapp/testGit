//
//  ImageViewController.swift
//  TestGitHubProj
//
//  Created by Viacheslav Markov on 29.09.2020.
//

import UIKit

class ImageViewController: UIViewController {
    
    @IBOutlet weak var closedButton: UIButton!
    
    var imageScrollView: ImageScrollView?
    
    
    let maxSize: CGFloat = 2
    let minSize: CGFloat = 0.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageScrollView = ImageScrollView(frame: view.bounds)
        guard let imageS = imageScrollView else { return }
        view.addSubview(imageS)
        
        setupImageScrollView()
        
        guard let imagePath = Bundle.main.path(forResource: "avatar2", ofType: "jpg") else { return }
        
        guard let image = UIImage(contentsOfFile: imagePath) else { return }
        
        self.imageScrollView?.set(image: image)

    }
    
    func setupImageScrollView() {
        
        imageScrollView?.translatesAutoresizingMaskIntoConstraints = false
        
        imageScrollView?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageScrollView?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageScrollView?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageScrollView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

        
//        closedButton.isHidden = true
//        scrollView.zoomScale = minSize * 2

    
}


