//
//  ViacheslavViewController.swift
//  TestGitHubProj
//
//  Created by Viacheslav Markov on 26.09.2020.
//

import UIKit
import WebKit

class ViacheslavViewController: UIViewController {
    
    @IBOutlet var myWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
   
    @IBAction func touchButtonLoadWebPage(_ sender: UIButton) {
        
        guard let url = URL(string: "https://www.google.com/?client=safari") else { return }
        let request = URLRequest(url: url)
        myWebView.load(request)
        
    }
    
    
    

    


}


