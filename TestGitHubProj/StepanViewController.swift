//
//  StepanViewController.swift
//  TestGitHubProj
//
//  Created by Stepan Niemykin on 26.09.2020.
//

import UIKit
import SafariServices
import Firebase

class StepanViewController: UIViewController {

    @IBOutlet weak var signInButtonPressed: UIButton!
    
    
    @IBAction func googleButton(_ sender: UIButton) {
        showSafari("https://www.google.com/?client=safari")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func showSafari(_ url: String) {
        guard let url = URL(string: url) else { return }
        
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
    }
    
    

}
