//
//  AnimationFrameViewController.swift
//  TestGitHubProj
//
//  Created by Anastasiia Spiridonova on 16.10.2020.
//

import UIKit

class AnimationFrameViewController: UIViewController {
    lazy var square = { return UIView() }()
    var animator1: UIViewPropertyAnimator!
    var animator2: UIViewPropertyAnimator!
    var animator3: UIViewPropertyAnimator!
    var animator4: UIViewPropertyAnimator!
    
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
        
        animator1 = UIViewPropertyAnimator(duration: 3, curve: .linear) {
            self.square.transform = CGAffineTransform
                .identity
                .translatedBy(x: self.view.frame.width - 80, y: 0)
            print(self.view.frame.height)
            print(self.view.frame.maxY)
        }
        animator1.addCompletion({ _ in
            self.animator2.startAnimation()
            
        })
        
        animator2 = UIViewPropertyAnimator(duration: 3, curve: .linear) {
            self.square.transform = CGAffineTransform
                .identity
                .translatedBy(x: self.view.frame.width - 80, y: 200)
        }
        animator2.addCompletion { (_) in
            self.animator3.startAnimation()
        }
        
        animator3 = UIViewPropertyAnimator(duration: 3, curve: .linear) {
            self.square.transform = CGAffineTransform
                .identity
                .translatedBy(x: 0, y: 200)
        }
        animator3.addCompletion { (_) in
            self.animator4.startAnimation()
        }
        
        animator4 = UIViewPropertyAnimator(duration: 3, curve: .linear) {
            self.square.transform = CGAffineTransform
                .identity
                .translatedBy(x: 0, y: 0)
        }
        
        animator1.startAnimation()
//        1 square.transform = CGAffineTransform
//            .identity
//            .translatedBy(x: self.view.frame.width - 80, y: 0)
//        2 square.transform.translatedBy(x: 0, y: 200)
//        3 square.transform.translatedBy(x: -(self.view.frame.width - 80), y: 0)
//        4 square.transform.translatedBy(x: 0, y: -200)
    }
    override func viewWillLayoutSubviews() {
        view.updateConstraints()
    }
    
}
