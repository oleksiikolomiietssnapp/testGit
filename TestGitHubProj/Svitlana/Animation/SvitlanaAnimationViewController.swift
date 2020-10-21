//
//  SvitlanaAnimationViewController.swift
//  TestGitHubProj
//
//  Created by Svitlana Korostelova on 16.10.2020.
//

import UIKit

class SvitlanaAnimationViewController: UIViewController {
    var animator: UIViewPropertyAnimator!
    
    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var reverceSwitcher: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        reverceSwitcher.isOn = false
        blueView.translatesAutoresizingMaskIntoConstraints = false
        blueView.center.y = view.center.y
        
        animator = UIViewPropertyAnimator(duration: 4, curve: .linear) { [unowned self] in
            self.blueView.center.x = self.view.frame.width
            let finalWidth = self.view.frame.width - 2
            let scaleWidth = finalWidth / self.blueView.frame.width
            self.blueView.transform = CGAffineTransform.identity
                .translatedBy(x: finalWidth / 2 - 24, y: 0)
                .scaledBy(x: scaleWidth, y: 1)
        }
        animator.startAnimation()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reverceSwitcherIsChanged), name: nil, object: nil)
    }
    @objc func reverceSwitcherIsChanged() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if self.reverceSwitcher.isOn {
                self.animator.isReversed = true
            } else {
                self.animator.isReversed = false
            }
        }
        
    }
}
