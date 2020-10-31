//
//  AnimationsViewController.swift
//  TestGitHubProj
//
//  Created by Stepan Niemykin on 16.10.2020.
//

import UIKit

class AnimationsViewController: UIViewController {
    var delay = 0.0
    var duration = 1.5

    @IBOutlet weak var dotsView: UIView!
    @IBAction func animationSwitchPressed(_ sender: UISwitch) {
    }
    
    @IBAction func speedSliderMoved(_ sender: UISlider) {
        duration = Double(sender.value + 1.0)
    }
    @IBAction func playButtonPressed(_ sender: UIButton) {
        delay = 0.0
        start()
    }
    
    var animator: UIViewPropertyAnimator?
    
    //creating 3 labels
    lazy var generatedLabels: [UILabel] = {
        var labels = [UILabel]()
        let labelWidth = CGFloat(30)
        let labelHeight = CGFloat(30)
        let spacing = CGFloat(15) + labelWidth
        
        var positionX = dotsView.frame.width / 2 - labelWidth / 2 - spacing
        let positionY = dotsView.frame.height / 2 - labelHeight / 2 + 20
        
        for _ in 0..<3 {
            let label = UILabel(frame: CGRect(x: positionX, y: positionY, width: labelWidth, height: labelHeight))
            label.backgroundColor = .red
            
            label.clipsToBounds = true
            label.layer.cornerRadius = label.frame.width / 2
            
            labels.append(label)
            positionX += spacing
        }
        
        return labels
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for label in generatedLabels {
            self.dotsView.addSubview(label)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //animateLabels(labels: generatedLabel)
        start()
    }
    
    func start() {
        for label in generatedLabels {
            createAnimators(label: label)
            animator?.startAnimation(afterDelay: delay)
            delay += duration / Double(generatedLabels.count)
        }
    }
    
    func animateLabels(labels: [UILabel]) {
        let duration = 1.0
        var delay = 0.0
        
        for index in 0..<labels.count {
            UIView.animate(withDuration: duration, delay: delay, options: [.autoreverse, .repeat, .curveEaseInOut], animations: {
                labels[index].frame.origin.y -= 40.0
                labels[index].layer.opacity = 0.2
            }, completion: {_ in
                labels[index].frame.origin.y += 40.0
                labels[index].layer.opacity = 1.0
            })
            delay += duration / Double(labels.count)
        }
    }
    
    func createAnimators(label: UILabel) {
        let reversedAnimator = UIViewPropertyAnimator(duration: duration, curve: .easeIn)
        animator = UIViewPropertyAnimator(duration: duration, curve: .easeIn)
            
        animator?.addAnimations {
            label.frame.origin.y -= 40.0
            label.layer.opacity = 0.2
        }
        
        reversedAnimator.addAnimations {
            label.frame.origin.y += 40.0
            label.layer.opacity = 1.0
        }
        
        animator?.addCompletion({_ in
            reversedAnimator.startAnimation()
        })
    }
}
