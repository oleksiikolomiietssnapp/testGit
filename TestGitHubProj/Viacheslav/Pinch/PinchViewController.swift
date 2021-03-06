//
//  PinchViewController.swift
//  TestGitHubProj
//
//  Created by Viacheslav Markov on 02.10.2020.
//

import UIKit

class PinchViewController: UIViewController {
    
    @IBOutlet var closedButton: UIButton!
    @IBOutlet var imageView: UIImageView!
    
    var imageViewScale: CGFloat = 1.0
    let maxScale: CGFloat = 4.0
    let minScale: CGFloat = 1
    
    var isTap = false
    lazy var zoomingTap: UITapGestureRecognizer = {
        let zoomingTap = UITapGestureRecognizer(target: self, action: #selector(handleZoomingTap))
        zoomingTap.numberOfTapsRequired = 2
        return zoomingTap
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        closedButton.isHidden = true
        
        imageView.isUserInteractionEnabled = true
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchAction))

        imageView.addGestureRecognizer(pinchGesture)
        imageView.addGestureRecognizer(zoomingTap)
        
    }
    
    @IBAction func touchClosedButtom(_ sender: Any) {
        
        closedButton.isHidden = true
        imageView.transform.a = minScale * 2
        imageView.transform.d = minScale * 2
        
    }

    @objc func pinchAction(recognizer: UIPinchGestureRecognizer) {
        
        if recognizer.state == .began || recognizer.state == .changed {
            let pinchScale: CGFloat = recognizer.scale
            
            if imageViewScale * pinchScale < maxScale && imageViewScale * pinchScale > minScale {
                imageViewScale *= pinchScale
                imageView.transform = (imageView.transform.scaledBy(x: pinchScale, y: pinchScale))

                if imageView.transform.a >= (maxScale - 0.1) {
                    closedButton.isHidden = false
                } else {
                    closedButton.isHidden = true
                }
            }
            recognizer.scale = 1.0
        }
    }
    
    @objc func handleZoomingTap(sender: UITapGestureRecognizer) {
        
        let location = sender.location(in: sender.view)
        self.zoom(point: location, animated: true)
    }
    
    func zoom(point: CGPoint, animated: Bool) {
       
        if !isTap {
            imageView.transform = imageView.transform.scaledBy(x: maxScale, y: maxScale)
            isTap = true
        } else {
            imageView.transform.a = minScale
            imageView.transform.d = minScale
            isTap = false
        }
    }

}
