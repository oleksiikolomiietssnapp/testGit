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
    
    @IBOutlet var colorfulViews: [UIView]!
    @IBOutlet var sidesOfFrames: [UIView]!

    var isTouchToFrame = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        for view in colorfulViews {
            cornerRadius(to: view)
            alphaView(to: view)
        }
        
        for view in sidesOfFrames {
            frameIsHiden(part: view)
        }
        
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
    
    func alphaView(to circleView: UIView) {
        circleView.alpha = 0.6
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
        
        let leftFrame = leftFrameView.center.x + resultView.frame.width / 2 + 1
        let rightFrame = rightFrameView.center.x - (resultView.frame.width / 2 + 1)
        
        let topFrame = topFrameView.center.y + resultView.frame.height / 2 + 1
        let leadingFrame = leadingFrameView.center.y - resultView.frame.height / 2 - 1
        
        let translation = recognaizer.translation(in: self.view)

        var newX = resultView.center.x + translation.x
        var newY = resultView.center.y + translation.y
        
        if (newX - leftFrame) < 1 {
            touchToFrame(by: (newX - leftFrame), side: leftFrameView)
            newX = leftFrame
        } else {
            unTouchToFrame(by: (newX - leftFrame), side: leftFrameView)
        }
        
        if (newX - rightFrame) > -1 {
            touchToFrame(by: (newX - leftFrame), side: rightFrameView)
            newX = rightFrame
        } else {
            unTouchToFrame(by: (newX - leftFrame), side: rightFrameView)
        }
        
        if (newY - topFrame) < 1 {
            touchToFrame(by: (newX - leftFrame), side: topFrameView)
            newY = topFrame
        } else {
            unTouchToFrame(by: (newX - leftFrame), side: topFrameView)
        }
        
        if (newY - leadingFrame) > -1 {
            touchToFrame(by: (newX - leftFrame), side: leadingFrameView)
            newY = leadingFrame
        } else {
            unTouchToFrame(by: (newX - leftFrame), side: leadingFrameView)
        }

        resultView.center = CGPoint(x: newX, y: newY)
        recognaizer.setTranslation(CGPoint.zero, in: self.view)
        }
    
    func frameIsHiden(part OfFrame: UIView) {
        if OfFrame.isHidden {
            OfFrame.isHidden = false
        } else {
            OfFrame.isHidden = true
        }
    }
    
    func touchToFrame(by: CGFloat, side: UIView) {
        if by > 0 || by < 1 {
            side.isHidden = false
            isTouchToFrame = true
        } else {
            side.isHidden = true
        }
    }
    
    func unTouchToFrame(by: CGFloat, side: UIView) {
            side.isHidden = true
            isTouchToFrame = false
    }
}
