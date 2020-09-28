//
//  SvitlanaTextViewController.swift
//  TestGitHubProj
//
//  Created by Svitlana Korostelova on 27.09.2020.
//

import Foundation
import UIKit



class SvitlanaTextViewController: UIViewController {
    @IBOutlet weak var showButton: UIButton!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    var showText = true
    @IBAction func showMoreOrLess(_ sender: UIButton) {
        if showText {
            textView.isScrollEnabled = true
            bottomConstraint.constant = 16
            showButton.setTitle("Show less", for: .normal)
        } else {
            textView.isScrollEnabled = false
            bottomConstraint.constant = 399
            showButton.setTitle("Show more", for: .normal)
        }
        showText = !showText
//        textView.isScrollEnabled = showText
        
    }
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.textContainer.lineBreakMode = .byTruncatingTail
        
    }

}
