//
//  SvitlanaTextViewController.swift
//  TestGitHubProj
//
//  Created by Svitlana Korostelova on 27.09.2020.
//

import Foundation
import UIKit



class SvitlanaTextViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var showButton: UIButton!
    @IBOutlet weak var heightOfTextView: NSLayoutConstraint!
    @IBOutlet weak var textView: UITextView!
    
    var showText = false
    
    @IBAction func showMoreOrLess(_ sender: UIButton) {
        showText = !showText
        setupConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.textContainer.lineBreakMode = .byTruncatingTail
    }
    
    fileprivate func setupConstraints() {
        textView.isScrollEnabled = showText
        if showText {
            heightOfTextView.priority = .defaultLow
            showButton.setTitle("Show less", for: .normal)
            
            scrollView.becomeFirstResponder()
        } else {
            heightOfTextView.priority = .required
            showButton.setTitle("Show more", for: .normal)
        }
    }
    
}
