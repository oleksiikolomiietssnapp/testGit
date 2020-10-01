//
//  PinchGestureRecognizer.swift
//  TestGitHubProj
//
//  Created by Viacheslav Markov on 01.10.2020.
//

import UIKit

class PinchGestureRecognizer: UIPinchGestureRecognizer {
    
    var imageZoom: UIImageView?
    
    func set(image: UIImage) -> Void {
        
        imageZoom?.removeFromSuperview()
        imageZoom = nil
        
        imageZoom = UIImageView(image: image)
        
    }

}
