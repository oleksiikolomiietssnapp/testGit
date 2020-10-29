//
//  ParallaxViewController.swift
//  TestGitHubProj
//
//  Created by Svitlana Korostelova on 29.10.2020.
//

import UIKit

class ParallaxViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
    }
    
   private func setupScrollView() {
    scrollView.contentSize.width = self.scrollView.frame.width * 7
    scrollView.isPagingEnabled = true
    }
}
