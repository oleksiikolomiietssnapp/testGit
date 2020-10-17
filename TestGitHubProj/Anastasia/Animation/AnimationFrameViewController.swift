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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        square.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        square.translatesAutoresizingMaskIntoConstraints = false
        animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
            self.square.frame = self.square.frame.offsetBy(dx: self.view.bounds.maxX - 80, dy: 0)
        }
        animator.startAnimation()
    }
    override func viewWillLayoutSubviews() {
        view.updateConstraints()
    }
    
}
