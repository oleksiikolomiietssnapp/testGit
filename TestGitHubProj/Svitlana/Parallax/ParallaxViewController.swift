//
//  ParallaxViewController.swift
//  TestGitHubProj
//
//  Created by Svitlana Korostelova on 29.10.2020.
//

import UIKit

class ParallaxViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    let texts = ["We guarantee you will receive many attractive job offers after the successful completion of the course!",
                 "Don`t miss your chance to change the world! You have a great opportunity to get up-to-date and high quality education and become a professional programmer!",
                 "Would you like to become a highly qualified programmer? Make the right decision, join our educational program! We set the goals and accomplish great results!",
                 "A year of persistent but interesting learning is enough to become a professional programmer ready to work in the  field of information technology!",
                 "Don`t lose your chance to get creative, promissing and  lucrative job, plan your future today!",
                 "You want to make money  doing what you like and enjoy modern career, don`t you? Choose your  way to IT world!",
                 "In the future there are two types of jobs: those, where You`ll tell the machine what to do - programming, and those, where the machine is going to tell you what to do!"]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        scrollView.layoutIfNeeded()
    }
    
    private func setupScrollView() {
        scrollView.contentSize.width = self.scrollView.frame.width * CGFloat(texts.count)
        scrollView.backgroundColor = .blue
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.bounces = false
        
        for (i, text) in texts.enumerated() {
            let frame = CGRect(x: self.scrollView.frame.width * CGFloat(i),
                                y: 0,
                                width: self.scrollView.frame.width,
                                height: self.scrollView.frame.height)
            
            let view = IntitaMainScreenView(frame: frame)
            
            view.intitaLabel.text = text
            self.scrollView.addSubview(view)
        }
    }
}
