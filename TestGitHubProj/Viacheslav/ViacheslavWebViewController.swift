//
//  ViacheslavWebViewController.swift
//  TestGitHubProj
//
//  Created by Viacheslav Markov on 28.09.2020.
//

import UIKit
import WebKit

class ViacheslavWebViewController: UIViewController {
    
    @IBOutlet var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let url = URL(string: "https://www.google.com") else { return }
        let request = URLRequest(url: url)
        webView.load(request)
        
    }

}
