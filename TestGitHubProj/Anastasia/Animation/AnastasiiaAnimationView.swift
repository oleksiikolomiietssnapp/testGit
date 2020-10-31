//
//  AnastasiiaAnimationView.swift
//  TestGitHubProj
//
//  Created by Anastasiia Spiridonova on 24.10.2020.
//

import UIKit

class AnastasiiaAnimationView: UIView {
    let animatedElement = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 80, height: 80)))
    weak var delegate: AnimationDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
        addSubview(animatedElement)
        animatedElement.backgroundColor = .red
    }
}
