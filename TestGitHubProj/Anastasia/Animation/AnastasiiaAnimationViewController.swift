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
    static weak var delegate: AnimationDelegate?
    
    @IBOutlet weak var repaetSwitch: UISwitch!
    
    @IBOutlet weak var reverseSwitch: UISwitch!
    
    @IBAction func pauseBtnPressed() {
        AnastasiiaAnimationViewController.delegate?.pauseAnimation()
    }
    @IBAction func playBtnPressed() {
        AnastasiiaAnimationViewController.delegate?.startAnimation()
    }
    @IBAction func stopBtnPressed() {
        AnastasiiaAnimationViewController.delegate?.stopAnimation()
    }
    
    override func viewDidLoad() {
        
    }
}
