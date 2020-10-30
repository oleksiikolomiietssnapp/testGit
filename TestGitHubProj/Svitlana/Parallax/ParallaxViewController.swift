//
//  ParallaxViewController.swift
//  TestGitHubProj
//
//  Created by Svitlana Korostelova on 29.10.2020.
//

import UIKit

class ParallaxViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var programTheFutureLabel: UILabel!
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
        startBtn.layer.cornerRadius = 5.0
        startBtn.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        startBtn.backgroundColor = UIColor(red: 82.0/255.0, green: 117.0/255.0, blue: 160.0/255.0, alpha: 1)
    }
    
    private func setupScrollView() {
        scrollView.backgroundColor = .blue
//        let frame = CGRect(
//            x: 0,
//            y: self.view.frame.height/3,
//            width: self.view.frame.width,
//            height: self.view.frame.height/3)
//        scrollView.frame = frame
//        
        scrollView.contentSize.width = self.view.frame.width * CGFloat(texts.count)
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        for (i, text) in texts.enumerated() {
            let frame = CGRect(
                x: self.view.frame.width * CGFloat(i),
                y: 0,
                width: self.scrollView.frame.width,
                height: self.scrollView.frame.height)
            
            let view = IntitaMainScreenView(frame: frame)
            
            view.intitaLabel.text = text
            self.scrollView.addSubview(view)
        }
    }
}
