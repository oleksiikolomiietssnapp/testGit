//
//  AnastasiaViewController.swift
//  TestGitHubProj
//
//  Created by Anastasiia Spiridonova on 28.09.2020.
//

import UIKit
import SafariServices

class AnastasiaViewController: UIViewController {
    
    let k_wikiUrl = "https://www.wikipedia.org"
     
    @IBAction func wikiBtnPressed() {
        showSafari(k_wikiUrl)
    }
    
    func showSafari(_ url: String) {
        guard let url = URL(string: url) else {
            return
        }
        
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        let vc = SFSafariViewController(url: url, configuration: config)
        present(vc, animated: true)
    }
}
