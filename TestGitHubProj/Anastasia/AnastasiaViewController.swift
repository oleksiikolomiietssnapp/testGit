//
//  AnastasiaViewController.swift
//  TestGitHubProj
//
//  Created by Anastasiia Spiridonova on 28.09.2020.
//

import UIKit
import SafariServices

class AnastasiaViewController: UIViewController, SFSafariViewControllerDelegate {
    
    let k_wikiUrl = "https://www.wikipedia.org"
    
    let button = UIButton(type: UIButton.ButtonType.custom)
    
    @IBOutlet var textViewController: UIView!
    
    @IBOutlet weak var wikiButton: UIButton!
    
     
    @IBAction func btnPressed(_ sender: UIButton) {
        if sender == wikiButton {
            showSafari(k_wikiUrl)
        } else {
            present(TextViewController(), animated: true, completion: nil)
        }
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
    
    func addButton(_ button: UIButton) {
        view.addSubview(button)
    }
    
    func changeButtonFrame(_ button: UIButton) {
        button.frame = CGRect(x: view.frame.midX - wikiButton.frame.width / 2, y: view.frame.midY + wikiButton.frame.height / 2 + 8, width: wikiButton.frame.width, height: wikiButton.frame.height / 2)
    }
    
    func customizeBtn(_ button: UIButton) {
        changeButtonFrame(button)
        button.setTitle("Text", for: UIControl.State.normal)
        button.backgroundColor = wikiButton.backgroundColor
        button.setTitleColor(wikiButton.currentTitleColor, for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: UIFont.Weight.light)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton(button)
        customizeBtn(button)
        button.addTarget(self, action: #selector(btnPressed), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        changeButtonFrame(button)
    }
}
