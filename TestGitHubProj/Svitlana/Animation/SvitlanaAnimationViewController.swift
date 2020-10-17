//
//  SvitlanaAnimationViewController.swift
//  TestGitHubProj
//
//  Created by Svitlana Korostelova on 16.10.2020.
//

import Foundation
import UIKit

class SvitlanaAnimationViewController: UIViewController {
    @IBOutlet weak var slider1: UISlider!
    
    @IBOutlet weak var blueViewWidth: NSLayoutConstraint! //unneed
    var animator: UIViewPropertyAnimator!
    
    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var reverceSwitcher: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        reverceSwitcher.isOn = false
        
//        let slider = UISlider()
//        slider.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(slider)
//
//        slider.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        slider.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        slider1.translatesAutoresizingMaskIntoConstraints = false
        
//        slider1.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        slider1.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        slider1.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
//        slider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
        
        blueView.translatesAutoresizingMaskIntoConstraints = false
        blueView.center.y = view.center.y
        
        let blueBox = UIView(frame: CGRect(x: -64, y: 0, width: 128, height: 128))
        blueBox.translatesAutoresizingMaskIntoConstraints = false
        blueBox.backgroundColor = UIColor.blue
        blueBox.center.y = view.center.y
        view.addSubview(blueBox)
        
//        animator.addCompletion(<#T##completion: (UIViewAnimatingPosition) -> Void##(UIViewAnimatingPosition) -> Void#>) до старта
        
        animator = UIViewPropertyAnimator(duration: 2, curve: .linear) { [unowned self, blueBox] in
            blueBox.center.x = self.view.frame.width
            self.blueView.center.x = self.view.frame.width
            //            blueBox.transform = CGAffineTransform(rotationAngle: CGFloat.pi).scaledBy(x: 0.001, y: 0.001)
            
        }
        
        animator.startAnimation()
//        animator.pauseAnimation()
//        animator.stopAnimation(<#T##withoutFinishing: Bool##Bool#>)
        
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
    @objc func sliderChanged(_ sender: UISlider) {
        animator.fractionComplete = CGFloat(sender.value)
    }
}
