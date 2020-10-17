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
    
    @IBOutlet weak var switchRevers: UISwitch!
    @IBOutlet weak var reversLabel: UILabel!
    
    @IBOutlet weak var switchReapet: UISwitch!
    @IBOutlet weak var repeatLabel: UILabel!
    
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var horizontalSlider: UISlider!
    
//    var minSize: CGFloat!
//    var maxSize = UIScreen.main.bounds.width * 0.9
    
    var startSize = CGAffineTransform(scaleX: 1, y: 1)
    var finishSize = CGAffineTransform(scaleX: 8, y: 8)
    var step = 0
    var isPresedStartButton = false
    var isPresedStopButton = false
    var isPresedPauseButton = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        horizontalSlider.addTarget(self, action: #selector(sliderChanged), for: .allEvents)
        cornerRadius(to: animatedView)
//        UIView.animate(withDuration: 3.0) {
//            let finalWidth = self.view.frame.width - 32
//            let scaleWidth = finalWidth / self.animatedView.frame.width
//            self.animatedView.transform = CGAffineTransform.identity
//                .translatedBy(x: finalWidth / 2 - 16, y: 0)
//                .scaledBy(x: scaleWidth, y: 1)
//        }
//        let yrt = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 4, delay: 0, options: [.curveLinear], animations: {
//            self.animatedView.backgroundColor = .cyan
//        })
//
//        yrt.addCompletion({ _ in
//        yrt.fractionComplete = .
//            self.percentLabel.text = "\(yrt.fractionComplete)"
//        })

    }
    
    func cornerRadius(to circleView: UIView) {
        circleView.layer.cornerRadius = circleView.layer.frame.height / 2
    }
    
    @IBAction func touchPauseButton(_ sender: Any) {
        
    }
    
    @IBAction func touchStopButton(_ sender: Any) {
        
    }
    
    @IBAction func touchStartButton(_ sender: UIButton) {

        switch sender.tag {
        case 0:
            pressedPauseButton(sender: sender)
        case 1:
            pressedStartButton(sender: sender)
        case 2:
            pressedStopButton(sender: sender)
        default:
            break
        }
        
    }
    
    func pressedStartButton(sender: UIButton) {
        
        startButton.isEnabled = false
//        pauseButton.isEnabled = true
        
        switch step {
        case 0:
            self.step = 1
            animation(color: .green, transform: finishSize, sender: sender)
        case 1:
            self.step = 2
            animation(color: .blue, transform: startSize, sender: sender)
        case 2:
            self.step = 3
            animation(color: .yellow, transform: finishSize, sender: sender)
        case 3:
            self.step = 0
            animation(color: .red, transform: startSize, sender: sender)
        default: break
        }
    }
    
    func pressedPauseButton(sender: UIButton) {
        animator.pauseAnimation()
        
        percentLabel.text = "\(animator.fractionComplete)"
        horizontalSlider.value = Float(animator.fractionComplete) * 100.0
//        startButton.isEnabled = true
//        pauseButton.isEnabled = false
//
    }
    
    func pressedStopButton(sender: UIButton) {
        startButton.isEnabled = true
        pauseButton.isEnabled = true
        
        animator.stopAnimation(true)
    }
    var animator: UIViewPropertyAnimator!
    func animation(color: UIColor, transform: CGAffineTransform, sender: UIButton) {
        
        let duration = 2.0
        animator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: duration, delay: 0, options: .curveLinear, animations: {
            self.animatedView.backgroundColor = color
            self.animatedView.transform = transform
        }, completion: { _ in
            self.touchStartButton(sender)
            
          })
//        animator.pauseAnimation()
        
    }
    
    @objc func sliderChanged(_ sender: UISlider) {
        animator?.pauseAnimation()
        animator?.fractionComplete = CGFloat(sender.value) / 100
    }
    
}
