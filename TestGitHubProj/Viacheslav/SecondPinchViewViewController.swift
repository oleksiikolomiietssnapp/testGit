//
//  SecondPinchViewViewController.swift
//  TestGitHubProj
//
//  Created by Viacheslav Markov on 02.10.2020.
//

import UIKit

class SecondPinchViewViewController: UIViewController {
    
    @IBOutlet var closedButton: UIButton!
    @IBOutlet var imageView: UIImageView!
    
    var imageViewScale: CGFloat = 1.0
    let maxScale: CGFloat = 4.0
    let minScale: CGFloat = 0.5

    override func viewDidLoad() {
        super.viewDidLoad()
        
        closedButton.isHidden = true
        
        imageView.isUserInteractionEnabled = true
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchAction))

        imageView.addGestureRecognizer(pinchGesture)
        
    }
    
    @IBAction func touchClosedButtom(_ sender: Any) {
        
        closedButton.isHidden = true
        imageView.transform.a = minScale * 2
        imageView.transform.d = minScale * 2
        
    }
    
    @objc func pinch(sender: UIPinchGestureRecognizer) {
        
        guard let pinchGes = sender.view else { return }
        
        pinchGes.transform = pinchGes.transform.scaledBy(x: sender.scale, y: sender.scale)
        sender.scale = 1
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
    

}
