//
//  TextViewViewController.swift
//  TestGitHubProj
//
//  Created by Stepan Niemykin on 26.09.2020.
//

import Foundation

import UIKit

class TextViewViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func moreLessButtonPressed(_ sender: UIButton) {
        if textView.isScrollEnabled {
            textView.isScrollEnabled = false
            sender.setTitle("more", for: .normal)
        } else {
            textView.isScrollEnabled = true
            sender.setTitle("less", for: .normal)
        }
    }
    
    override func viewDidLoad() {
    }
}
