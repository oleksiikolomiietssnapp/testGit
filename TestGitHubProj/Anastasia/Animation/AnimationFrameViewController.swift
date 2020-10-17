//
//  AnimationFrameViewController.swift
//  TestGitHubProj
//
//  Created by Anastasiia Spiridonova on 16.10.2020.
//

import UIKit

class AnimationFrameViewController: UIViewController {
    lazy var square = { return UIView() }()
    var animator: UIViewPropertyAnimator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(square)
        view.backgroundColor = .systemGray
        square.backgroundColor = .red
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        square.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        square.translatesAutoresizingMaskIntoConstraints = false
        animator = UIViewPropertyAnimator(duration: 3, curve: .linear) {
            self.square.transform = CGAffineTransform.identity.translatedBy(x: self.view.frame.width - 80, y: self.view.frame.height - 80)
            print(self.view.frame.height)
            print(self.view.frame.maxY)
        }
        animator.startAnimation()
    }
    override func viewWillLayoutSubviews() {
        view.updateConstraints()
    }
    
}
