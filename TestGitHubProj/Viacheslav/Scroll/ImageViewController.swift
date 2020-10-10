//
//  ImageViewController.swift
//  TestGitHubProj
//
//  Created by Viacheslav Markov on 29.09.2020.
//

import UIKit

class ImageViewController: UIViewController {
    
    enum Orientation: Int {
        case landscapeLeft = 3
        case landscapeRight = 4
        case portrait = 1
        
        var rotate: Int {
            let dev = UIDevice.current.orientation.hashValue
            switch self {
            case .portrait:
                return dev
            case .landscapeLeft, .landscapeRight:
                return dev
            }
        }
    }
    
    @IBOutlet weak var closedButton: UIButton!
    
    var imageScrollView: ImageScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        closedButton.isHidden = true
        
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
        
        imageScrollView?.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        imageScrollView?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageScrollView?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageScrollView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
