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
    let texts = ["1 We guarantee you will receive many attractive job offers after the successful completion of the course!",
                 "2 Don`t miss your chance to change the world! You have a great opportunity to get up-to-date and high quality education and become a professional programmer!",
                 "3 Would you like to become a highly qualified programmer? Make the right decision, join our educational program! We set the goals and accomplish great results!",
                 "4 A year of persistent but interesting learning is enough to become a professional programmer ready to work in the  field of information technology!",
                 "5 Don`t lose your chance to get creative, promissing and  lucrative job, plan your future today!",
                 "6 You want to make money  doing what you like and enjoy modern career, don`t you? Choose your  way to IT world!",
                 "7 In the future there are two types of jobs: those, where You`ll tell the machine what to do - programming, and those, where the machine is going to tell you what to do!"]
    var timer: Timer?
    var xOffSet = 0
    var directionMultiplier = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        scrollView.layoutIfNeeded()
        startBtn.layer.cornerRadius = 5.0
        startBtn.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        startBtn.backgroundColor = UIColor(red: 82.0/255.0, green: 117.0/255.0, blue: 160.0/255.0, alpha: 1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: (#selector(timerAction)), userInfo: nil, repeats: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        timer?.invalidate()
        timer = nil
    }
    
    private func setupScrollView() {
        scrollView.backgroundColor = .blue
        
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
            view.tag = i+10
            view.intitaLabel.text = text
            self.scrollView.addSubview(view)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let tempo = 300 / scrollView.frame.width
        for i in 0 ..< texts.count {
            guard let parallaxView = scrollView.viewWithTag(i + 10) as? IntitaMainScreenView else {return}
            let newX: CGFloat = tempo * (scrollView.contentOffset.x - CGFloat(i) * scrollView.frame.width)
            parallaxView.intitaLabel.frame = CGRect(
                x: newX,
                y: parallaxView.intitaLabel.frame.origin.y,
                width: parallaxView.intitaLabel.frame.width,
                height: parallaxView.intitaLabel.frame.height)
        }
    }
    
    @objc func timerAction() {
        if xOffSet >= Int(view.frame.width) * (texts.count-1) {
            directionMultiplier = -1
            
        } else if xOffSet <= 0 {
            directionMultiplier = 1
        }
        xOffSet += Int(view.frame.width) * directionMultiplier
        UIView.animate(withDuration: 1, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: { [weak self] in
            guard let self = self else { return }
            self.scrollView.contentOffset.x = CGFloat(self.xOffSet)
        }, completion: nil)
    }
}
