//
//  AnastasiiaAnimationViewController.swift
//  TestGitHubProj
//
//  Created by Anastasiia Spiridonova on 17.10.2020.
//

import UIKit

protocol AnimationDelegate: AnyObject {
    func startAnimation()
    func pauseAnimation()
    func stopAnimation()
    func continueAnimation()
}

class AnastasiiaAnimationViewController: UIViewController {
    @IBOutlet weak var animationFrame: AnastasiiaAnimationView!
    
    @IBOutlet weak var repaetSwitch: UISwitch!
    
    @IBOutlet weak var reverseSwitch: UISwitch!
    
    let animationDuration = 4.0
    
    private var squarePosition: CGPoint {
        return animationFrame.animatedElement.center
    }
    private var viewPerimetr: Double {
        return Double(animationFrame.frame.width + animationFrame.frame.height) * 2
    }
    
    private var xAxisMovementDuration: Double {
        let shift = Double(animationFrame.frame.width - animationFrame.animatedElement.frame.width)
        return (animationDuration * shift) / (viewPerimetr - Double(animationFrame.animatedElement.frame.width) * 4)
    }
    private var yAxisMovementDuration: Double {
        let shift = Double(animationFrame.frame.height - animationFrame.animatedElement.frame.width)
        return (animationDuration * shift) / (viewPerimetr - Double(animationFrame.animatedElement.frame.width) * 4)
    }
    
    lazy var animator1 = { return UIViewPropertyAnimator(duration: xAxisMovementDuration, curve: .linear) {
        self.animationFrame.animatedElement.center.x = self.animationFrame.frame.width - self.animationFrame.animatedElement.frame.width / 2
    }}()
    lazy var animator2 = { return UIViewPropertyAnimator(duration: xAxisMovementDuration, curve: .linear) {
        self.animationFrame.animatedElement.center.y = self.animationFrame.frame.height - self.animationFrame.animatedElement.frame.width / 2
    }}()
    lazy var animator3 = { return UIViewPropertyAnimator(duration: xAxisMovementDuration, curve: .linear) {
        self.animationFrame.animatedElement.center.x = self.animationFrame.animatedElement.frame.width / 2
    }}()
    lazy var animator4 = { return UIViewPropertyAnimator(duration: xAxisMovementDuration, curve: .linear) {
        self.animationFrame.animatedElement.center.y = self.animationFrame.animatedElement.frame.width / 2
    }}()
    
    @IBAction func pauseBtnPressed() {
        
    }
    @IBAction func playBtnPressed() {
        startAnimation()
    }
    @IBAction func stopBtnPressed() {
        stopAnimation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animationFrame.delegate = self
        animator1.addCompletion {_ in
            self.animator2.startAnimation()
        }
        animator2.addCompletion {_ in
            self.animator3.startAnimation()
        }
        animator3.addCompletion {_ in
            self.animator4.startAnimation()
        }
    }
}

extension AnastasiiaAnimationViewController: AnimationDelegate {
    func startAnimation() {
        animator1.startAnimation()
    }

    func pauseAnimation() {
    }

    func stopAnimation() {
        animator1.stopAnimation(false)
        animator2.stopAnimation(false)
        animator3.stopAnimation(false)
        animator4.stopAnimation(false)
        animationFrame.animatedElement.frame.origin = .zero
    }

    func continueAnimation() {
    }

}
