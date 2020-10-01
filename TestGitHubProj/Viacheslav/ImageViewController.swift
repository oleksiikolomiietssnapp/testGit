//
//  ImageViewController.swift
//  TestGitHubProj
//
//  Created by Viacheslav Markov on 29.09.2020.
//

import UIKit

class ImageViewController: UIViewController {
    
//    var imageZoomView: ImageScrollView?
//
//    func setup() {
//        imageZoomView?.translatesAutoresizingMaskIntoConstraints = false
//        imageZoomView?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        imageZoomView?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        imageZoomView?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        imageZoomView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var closedButton: UIButton!
    
    
    let maxSize: CGFloat = 2
    let minSize: CGFloat = 0.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        imageZoomView = ImageScrollView(frame: view.bounds)
//        guard let image = imageZoomView else { return }
//        view.addSubview(image)
//        setup()

        closedButton.isHidden = true
        
        scrollView.maximumZoomScale = maxSize
        scrollView.minimumZoomScale = minSize
        
        scrollView.delegate = self
    }
    
    @IBAction func touchClosedButton(_ sender: UIButton) {
        
        closedButton.isHidden = true
        scrollView.zoomScale = minSize * 2
    }
    
}

extension ImageViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale >= maxSize {
            closedButton.isHidden = false
        }
    }
}

