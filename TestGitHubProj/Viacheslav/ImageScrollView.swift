//
//  ImageScrollView.swift
//  TestGitHubProj
//
//  Created by Viacheslav Markov on 01.10.2020.
//

import UIKit

class ImageScrollView: UIScrollView {

    var imageZoomView: UIImageView?
    
    func set(image: UIImage) -> Void {
        
        imageZoomView?.removeFromSuperview()
        imageZoomView = nil
        
        imageZoomView = UIImageView(image: image)
        
        guard let image = imageZoomView else { return }
        self.addSubview(image)
    }

}
