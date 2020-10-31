//
//  BezierPathProgressBarVC.swift
//  TestGitHubProj
//
//  Created by Svitlana Korostelova on 17.10.2020.
//

import UIKit

class BezierPathProgressBarVC: UIViewController {
    
    @IBOutlet weak var progressBarView: PlainHorizontalProgressBar!
    
    @IBAction func pause(_ sender: UIButton) {
        timer?.invalidate()
    }
    @IBAction func play(_ sender: UIButton) {
        startTimer()
    }
    @IBAction func stop(_ sender: UIButton) {
        timer?.invalidate()
        if reverceSwitcher.isOn {
            progressCounter = 1.0
        } else {
            progressCounter = 0.0
        }
    }
    @IBAction func reverce(_ sender: UISwitch) {
        if reverceSwitcher.isOn {
            progressCounter = 1.0
        } else {
            progressCounter = 0.0
        }
    }
    
    @IBOutlet weak var repeatSwitcher: UISwitch!
    @IBOutlet weak var reverceSwitcher: UISwitch!
    
    var timer: Timer?
    var progressCounter: Float = 0.0 {
        didSet {
            progressBarView.progress = CGFloat(progressCounter)
        }
    }
    let duration:Float = 100.0
    var progressIncrement:Float {
        return 1.0 / duration
    }
    
    @objc func showProgress() {
        if progressCounter <= 0.0 && reverceSwitcher.isOn
            || !reverceSwitcher.isOn && progressCounter >= 1.0 {
            if repeatSwitcher.isOn {
                if reverceSwitcher.isOn {
                    progressCounter = 1.0
                } else {
                    progressCounter = 0.0
                }
            } else {
                timer?.invalidate()
            }
            return
        }
        if reverceSwitcher.isOn {
            progressCounter -= progressIncrement
        } else {
            progressCounter += progressIncrement
        }
    }
    
    fileprivate func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.showProgress), userInfo: nil, repeats: true)
    }
    
}

class PlainHorizontalProgressBar: UIView {
    var color: UIColor = .blue {
        didSet { setNeedsDisplay() }
    }
    
    var progress: CGFloat = 0 {
        didSet { setNeedsDisplay() }
    }
    
    private let progressLayer = CALayer()
    private let backgroundMask = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }
    
    private func setupLayers() {
        layer.addSublayer(progressLayer)
    }
    
    override func draw(_ rect: CGRect) {
        backgroundMask.path = UIBezierPath(roundedRect: rect, cornerRadius: rect.height * 0.25).cgPath
        layer.mask = backgroundMask
        
        let progressRect = CGRect(origin: .zero, size: CGSize(width: rect.width * progress, height: rect.height))
        
        progressLayer.frame = progressRect
        progressLayer.backgroundColor = color.cgColor
    }
}
