//
//  ImageViewController.swift
//  TestGitHubProj
//
//  Created by Viacheslav Markov on 29.09.2020.
//

import UIKit

class ImageViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var closedButton: UIButton!
    
    
    let maxSize: CGFloat = 2
    let minSize: CGFloat = 0.5
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
