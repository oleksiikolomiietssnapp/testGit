//
//  StepanViewController.swift
//  TestGitHubProj
//
//  Created by Stepan Niemykin on 26.09.2020.
//

import UIKit
import SafariServices

class StepanViewController: UIViewController {


    @IBAction func googleButton(_ sender: UIButton) {
        showSafari("https://www.google.com/?client=safari")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func showSafari(_ url: String) {
        guard let url = URL(string: url) else { return }
        
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
    }

}
