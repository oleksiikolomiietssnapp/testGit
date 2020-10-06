//
//  PinchViewController.swift
//  TestGitHubProj
//
//  Created by Viacheslav Markov on 01.10.2020.
//

import UIKit

class PinchViewController: UIViewController {
    
    let imageView = UIImageView()
    let pinchGesture = UIPinchGestureRecognizer()
    
    var imageViewScale: CGFloat = 1.0
    let maxScale: CGFloat = 4.0
    let minScale: CGFloat = 1
    
    lazy var zoomingTap: UITapGestureRecognizer = {
        let zoomingTap = UITapGestureRecognizer(target: self, action: #selector(handleZoomingTap))
        zoomingTap.numberOfTapsRequired = 2
        return zoomingTap
    }()
    
    @IBOutlet var closedButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        closedButton.isHidden = true
        closedButton.window?.windowLevel = UIWindow.Level(rawValue: CGFloat.greatestFiniteMagnitude)
        
    }
    
    @IBAction func touchClosedButton(_ sender: UIButton) {
        
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

    }
    
    func zoomRect(scale: CGFloat, center: CGPoint) -> CGRect {
        
        let zoomRect = CGRect.zero
        
        return zoomRect
    }

}
