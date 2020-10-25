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
    
    private var xAxisMovementAnimator: UIViewPropertyAnimator {
        return UIViewPropertyAnimator(duration: xAxisMovementDuration, curve: .linear) { [self] in
            animationFrame.animatedElement.center.x = CGFloat(squareMaxXPosition)
        }
    }
    private var yAxisMovementAnimator: UIViewPropertyAnimator {
        return UIViewPropertyAnimator(duration: yAxisMovementDuration, curve: .linear) { [self] in
            animationFrame.animatedElement.center.y = CGFloat(squareMaxYPosition)
        }
    }
    
    private var squarePosition: CGPoint {
        return animationFrame.animatedElement.center
    }
    private var viewPerimetr: Double {
        return Double(animationFrame.frame.width + animationFrame.frame.height) * 2
    }
    private var squareMaxXPosition: CGFloat {
        return animationFrame.frame.width - animationFrame.animatedElement.frame.width / 2
    }
    private var squareMaxYPosition: CGFloat {
        return animationFrame.frame.height - animationFrame.animatedElement.frame.width / 2
    }
    private var xAxisMovementDuration: Double {
        let shift = Double(animationFrame.frame.width - animationFrame.animatedElement.frame.width)
        return (animationDuration * shift) / (viewPerimetr - Double(animationFrame.animatedElement.frame.width) * 4)
    }
    private var yAxisMovementDuration: Double {
        let shift = Double(animationFrame.frame.height - animationFrame.animatedElement.frame.width)
        return (animationDuration * shift) / (viewPerimetr - Double(animationFrame.animatedElement.frame.width) * 4)
    }
    
    @IBAction func pauseBtnPressed() {
        
    }
    @IBAction func playBtnPressed() {
        startAnimation()
    }
    @IBAction func stopBtnPressed() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animationFrame.delegate = self
    }
}

extension AnastasiiaAnimationViewController: AnimationDelegate {
    func startAnimation() {
        xAxisMovementAnimator.isReversed = false
        xAxisMovementAnimator.startAnimation()
        xAxisMovementAnimator.addCompletion { _ in
            self.yAxisMovementAnimator.isReversed = false
            self.yAxisMovementAnimator.startAnimation()
        }
        yAxisMovementAnimator.addCompletion { [self]_ in
            xAxisMovementAnimator.isReversed = true
            xAxisMovementAnimator.startAnimation()
        }
        xAxisMovementAnimator.addCompletion { [self]_ in
            yAxisMovementAnimator.isReversed = true
            yAxisMovementAnimator.startAnimation()
        }
    }

    func pauseAnimation() {
    }

    func stopAnimation() {
    }

    func continueAnimation() {
    }

}
