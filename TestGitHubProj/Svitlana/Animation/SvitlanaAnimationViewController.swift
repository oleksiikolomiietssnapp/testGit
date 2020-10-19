//
//  SvitlanaAnimationViewController.swift
//  TestGitHubProj
//
//  Created by Svitlana Korostelova on 16.10.2020.
//

import UIKit

class SvitlanaAnimationViewController: UIViewController {
    
//    @IBAction func showBPProgressBar(_ sender: UIButton) {
//        let sb = UIStoryboard(name: "BezierPathStoryboard", bundle: nil)
//       guard let vc = sb.instantiateViewController(withIdentifier: "BezierPathProgressBarVC") as? BezierPathProgressBarVC else {
//            print("error")
//            return
//        }
//        self.navigationController?.pushViewController(vc, animated: true)
//        
//    }
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
        
//        let blueBox = UIView(frame: CGRect(x: -64, y: 0, width: 128, height: 128))
//        blueBox.translatesAutoresizingMaskIntoConstraints = false
//        blueBox.backgroundColor = UIColor.blue
//        blueBox.center.y = view.center.y
//        view.addSubview(blueBox)
        
        //        animator.addCompletion{(position) in
        //        switch position {
        //        case .end:
        //            <#code#>
        //        case .current:
        //            <#code#>
        //        case .start:
        //        }
        //    }// или до старта
        
        animator = UIViewPropertyAnimator(duration: 2, curve: .linear) { [unowned self] in
            //            blueBox.center.x = self.view.frame.width
            self.blueView.center.x = self.view.frame.width
            //            blueBox.transform = CGAffineTransform(rotationAngle: CGFloat.pi).scaledBy(x: 0.001, y: 0.001)
            
            //            blueView.transform = CGAffineTransform(scaleX: (view.frame.width - 32)/self.blueView.frame.width, y: 1)
            //            blueView.transform = CGAffineTransform(translationX: <#T##CGFloat#>, y: <#T##CGFloat#>)
            let finalWidth = self.view.frame.width - 2
            let scaleWidth = finalWidth / self.blueView.frame.width
            self.blueView.transform = CGAffineTransform.identity
                .translatedBy(x: finalWidth / 2 - 24, y: 0)
                .scaledBy(x: scaleWidth, y: 1)
//            blueView.transform = CGAffineTransform.identity.translatedBy(x: finalWidth, y: 0).scaledBy(x: 100, y: 1)
            //вместо x = 100 высчитать по фреймам
        }
        
        animator.startAnimation()
        //        animator.pauseAnimation()
        //старт, сразу пауз. настроить , потом по плей должна быть континью и при этом устанавливать slider.value = animator.FractionComplete \\from 0...1
        
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
