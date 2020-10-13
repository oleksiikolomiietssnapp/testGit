//
//  CircleViewController.swift
//  TestGitHubProj
//
//  Created by Viacheslav Markov on 11.10.2020.
//

import UIKit

class CircleViewController: UIViewController {
    
    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var blueView: UIView!
    
    @IBOutlet weak var topFrameView: UIView!
    @IBOutlet weak var rightFrameView: UIView!
    @IBOutlet weak var leadingFrameView: UIView!
    @IBOutlet weak var leftFrameView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cornerRadius(to: greenView)
        cornerRadius(to: redView)
        cornerRadius(to: blueView)
        
        let panGreen = UIPanGestureRecognizer(target: self, action: #selector(dragTheCicrle))
        panGreen.name = "panGreen"
        greenView.addGestureRecognizer(panGreen)
        
        let panRed = UIPanGestureRecognizer(target: self, action: #selector(dragTheCicrle))
        panRed.name = "panRed"
        redView.addGestureRecognizer(panRed)
        
        let panBlue = UIPanGestureRecognizer(target: self, action: #selector(dragTheCicrle))
        panBlue.name = "panBlue"
        blueView.addGestureRecognizer(panBlue)
        
    }
    
    func cornerRadius(to circleView: UIView) {
        circleView.layer.cornerRadius = circleView.layer.frame.height / 2
    }
    
    @objc func dragTheCicrle(recognaizer: UIPanGestureRecognizer) {
        
        var someView: UIView?
        
        switch recognaizer.name {
        case "panGreen":
            someView = greenView
        case "panBlue":
            someView = blueView
        case "panRed":
            someView = redView
        default :
            break
        }
        
        guard let resultView = someView else { return }
        view.bringSubviewToFront(resultView)
        
        let leftFrame = resultView.frame.width / 2 + 4
        let rightFrame = view.center.x * 2 - (resultView.frame.width / 2 + 4)
        
        let topFrame = topFrameView.center.y + resultView.frame.height / 2 + 2
        let leadingFrame = leadingFrameView.center.y - resultView.frame.height / 2 - 2
        
        let translation = recognaizer.translation(in: self.view)

        var newX = resultView.center.x + translation.x
        var newY = resultView.center.y + translation.y
        
        if (newX - leftFrame) < 0 {
            newX = leftFrame + 1
        }
        
        if (newX - rightFrame) > 0 {
            newX = rightFrame - 1
        }
        
        if (newY - topFrame) < 0 {
            newY = topFrame + 1
        }
        
        if (newY - leadingFrame) > 0 {
            newY = leadingFrame - 1
        }

        resultView.center = CGPoint(x: newX, y: newY)
        recognaizer.setTranslation(CGPoint.zero, in: self.view)

        }
    
}
