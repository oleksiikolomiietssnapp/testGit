//
//  AnimationViewController.swift
//  TestGitHubProj
//
//  Created by Viacheslav Markov on 16.10.2020.
//

import UIKit

class AnimationViewController: UIViewController {
    
    @IBOutlet weak var animatedView: UIView!
    
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var horizontalSlider: UISlider!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    lazy var startSize = CGAffineTransform(scaleX: 1, y: 1)
    lazy var finishSize = CGAffineTransform(scaleX: 3, y: 3)
    lazy var leftPosition = CGAffineTransform(translationX: 0, y: 0)
    
    var centerPosition: CGAffineTransform!
    var rightPosition: CGAffineTransform!

    var animator: UIViewPropertyAnimator!
    var duration: Double!
    
    lazy var timer = Timer()
    var send: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stopButton.isEnabled = false
        
        centerPosition = CGAffineTransform(translationX: (self.view.bounds.width / 2) - 32, y: 0)
        rightPosition = CGAffineTransform(translationX: self.view.bounds.width - 64, y: 0)
        
        horizontalSlider.addTarget(self, action: #selector(sliderChanged), for: .allEvents)
        cornerRadius(to: animatedView)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            centerPosition = CGAffineTransform(translationX: (self.horizontalSlider.bounds.width) - 32, y: 0)
            rightPosition = CGAffineTransform(translationX: self.horizontalSlider.bounds.width * 2 - 32, y: 0)
        } else {
            centerPosition = CGAffineTransform(translationX: (self.view.bounds.width / 2) - 32, y: 0)
            rightPosition = CGAffineTransform(translationX: self.view.bounds.width - 64, y: 0)
        }
    }

    @objc func countUp() {
        curentValueFractionComplete()
        }
    
    func cornerRadius(to circleView: UIView) {
        circleView.layer.cornerRadius = circleView.layer.frame.height / 2
    }
    
    @IBAction func touchStartButton(_ sender: UIButton) {

        switch sender.tag {
        case 0:
            pressedPauseButton()
        case 1:
            pressedStartButton(sender: sender)
        case 2:
            pressedStopButton()
        default:
            break
        }
        
    }
    
    func pressedStartButton(sender: UIButton) {
        send = sender
        startButton.isEnabled = false
        stopButton.isEnabled = true
        
        if !pauseButton.isEnabled {
            self.animator.continueAnimation(withTimingParameters: .none,
                                            durationFactor: 1 - animator.fractionComplete)
            pauseButton.isEnabled = true
        } else {
            animation()
            animator.startAnimation()
            timer = Timer.scheduledTimer(timeInterval: 0.05,
                                         target: self,
                                         selector: #selector(countUp),
                                         userInfo: nil, repeats: true)
        }

    }
    
    func pressedPauseButton() {
        
        animator.pauseAnimation()
        
        percentLabel.text = "\(animator.fractionComplete)"
        horizontalSlider.value = Float(animator.fractionComplete)
        
        startButton.isEnabled = true
        pauseButton.isEnabled = false

    }
    
    func pressedStopButton() {
        
        stopButton.isEnabled = false
        animator.stopAnimation(true)
        
        startButton.isEnabled = true
        pauseButton.isEnabled = true
    }
    
    func curentValueFractionComplete() {

        if animator.fractionComplete >= 0.0 {
            let text = animator.fractionComplete
            self.percentLabel.text = "\(round(100 * text) / 100)"
            self.horizontalSlider.value = Float(animator.fractionComplete)
        }
    }
    
    @IBAction func touchSegmentedControl(_ sender: UISegmentedControl) {

    }
    
    func animation() {
        
        self.duration = 12 / Double(segmentedControl.selectedSegmentIndex + 1)

        animator = UIViewPropertyAnimator(duration: TimeInterval(self.duration), curve: .linear)
        animator.addAnimations {
            UIView.animateKeyframes(withDuration: self.duration, delay: 0, animations: {

            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25) {
                self.animatedView.transform = self.finishSize.concatenating(self.centerPosition)
                self.animatedView.backgroundColor = .green
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.5) {
                self.animatedView.transform = self.startSize.concatenating(self.rightPosition)
                self.animatedView.backgroundColor = .orange
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.75) {
                self.animatedView.transform = self.finishSize.concatenating(self.centerPosition)
                self.animatedView.backgroundColor = .blue
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 1) {
                self.animatedView.transform = self.startSize.concatenating(self.leftPosition)
                self.animatedView.backgroundColor = .red
            }

          }, completion: { _ in
            
            if !self.stopButton.isEnabled {
                self.animatedView.transform = CGAffineTransform(translationX: -0.01, y: 0)
                self.animatedView.backgroundColor = .red
            } else {
                self.pressedStartButton(sender: self.send)
            }
          })
        }
    }
    
    @objc func sliderChanged(_ sender: UISlider) {
        animator?.pauseAnimation()
        animator?.fractionComplete = CGFloat(sender.value)
    }
    
}
