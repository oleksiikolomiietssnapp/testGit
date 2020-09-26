//
//  ViewController.swift
//  TestGitHubProj
//
//  Created by  Oleksii Kolomiiets on 26.09.2020.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Please, do somnething
        print(multiply(f: 2, s: 3))
    }

    private func multiply(f: Int, s: Int) -> Int {
        return f * s
    }

}

