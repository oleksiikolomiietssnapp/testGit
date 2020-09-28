//
//  ViacheslavViewController.swift
//  TestGitHubProj
//
//  Created by Viacheslav Markov on 26.09.2020.
//

import UIKit
import SafariServices

class ViacheslavViewController: UIViewController {
    
    @IBOutlet var safariButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
   
    @IBAction func touchButtonGoogle(_ sender: UIButton) {
        
        let storybord = UIStoryboard(name: "ViacheslavStoryboard", bundle: nil)
        
        let vc = storybord.instantiateViewController(identifier: "ViacheslavWebViewController") as! ViacheslavWebViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    @IBAction func touchButtonSafari(_ sender: UIButton) {
        
        guard let url = URL(string: "https://www.apple.com") else { return }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
        
        safariButton.isHidden = true
        
    }
    
}


