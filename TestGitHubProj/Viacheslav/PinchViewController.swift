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
    let minScale: CGFloat = 0.5
    
//    let closedButtonTwo = UIButton()
    
    @IBOutlet var closedButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        closedButton.isHidden = true
        closedButton.window?.windowLevel = UIWindow.Level(rawValue: CGFloat.greatestFiniteMagnitude)
        
//        closedButtonTwo.frame = CGRect(x: 16, y: 96, width: 32, height: 32)
//        closedButtonTwo.setTitle("X", for: .normal)
//        closedButtonTwo.setTitleColor(.black, for: .normal)
//        closedButtonTwo.titleLabel?.font = UIFont(name: "Heiti TC", size: 32)
//
//        self.view.addSubview(closedButtonTwo)

//        imageView.frame = CGRect(x: 16, y: 64, width: 400, height: 300)
//        imageView.image = #imageLiteral(resourceName: "avatar")
//        imageView.isUserInteractionEnabled = true
//        
//        self.view.addSubview(imageView)
//        
//        imageView.center = view.center
//        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        
//        imageView.addGestureRecognizer(pinchGesture)
//        pinchGesture.addTarget(self, action: #selector(pinchAction))
        
//        let height = imageView.frame.height
//        print(height)
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
    


}
