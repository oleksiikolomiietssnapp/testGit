//
//  ViewController.swift
//  TestGitHubProj
//
//  Created by  Oleksii Kolomiiets on 26.09.2020.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func tapViacheslavButton(_ sender: Any) {
        let vStoryboard = UIStoryboard(name: "ViacheslavS", bundle: nil)
        let initialVC = vStoryboard.instantiateViewController(withIdentifier: "ViacheslavViewController")
        
        navigationController?.pushViewController(initialVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

}
