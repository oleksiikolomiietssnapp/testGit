//
//  AnastasiaViewController.swift
//  TestGitHubProj
//
//  Created by Anastasiia Spiridonova on 28.09.2020.
//

import UIKit
import SafariServices

class AnastasiaViewController: UIViewController, SFSafariViewControllerDelegate {
    
    lazy private var kWikiUrl = { return "https://www.wikipedia.org" }()
    
    lazy private var  button = { return UIButton(type: UIButton.ButtonType.custom) }()
    
    lazy private var requestBtn = { return UIButton(type: UIButton.ButtonType.custom) }()
    
    @IBOutlet private var textViewController: UIView!
    
    @IBOutlet weak private var wikiButton: UIButton!
    
    @IBAction private func btnPressed(_ sender: UIButton) {
        if sender == wikiButton {
            showSafari(kWikiUrl)
        } else if sender == button {
            self.navigationController?.pushViewController(TextViewController(), animated: true)
        } else {
            let vc = RequestViewController()
            guard let url = URL(string: "https://api.agify.io/?name%5B%5D=michael&name%5B%5D=matthew&name%5B%5D=jane") else {
                return
            }
            NetworkingService.request(url: url, completitionHandler: {(data, _, error) in
                if error != nil {
                    return
                }
                do {
                    vc.users = try JSONDecoder().decode([User].self, from: data!)
                    DispatchQueue.main.async {
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            })
        }
    }
    
    private func showSafari(_ url: String) {
        guard let url = URL(string: url) else {
            return
        }
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        let vc = SFSafariViewController(url: url, configuration: config)
        present(vc, animated: true)
    }
    
    private func addButton(_ button: UIButton) {
        view.addSubview(button)
    }
    
    private func changeButtonFrame(_ button: UIButton, frameY: CGFloat) {
        button.frame = CGRect(x: wikiButton.frame.minX, y: frameY, width: wikiButton.frame.width, height: wikiButton.frame.height / 2)
    }
    
    private func customizeBtn(_ button: UIButton, frameY: CGFloat, title: String) {
        changeButtonFrame(button, frameY: frameY)
        button.setTitle(title, for: UIControl.State.normal)
        button.backgroundColor = wikiButton.backgroundColor
        button.setTitleColor(wikiButton.currentTitleColor, for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: UIFont.Weight.light)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton(button)
        addButton(requestBtn)
        customizeBtn(button, frameY: view.frame.midY + wikiButton.frame.height / 2 + 8, title: "Text")
        customizeBtn(requestBtn, frameY: view.frame.midY - wikiButton.frame.height - 8, title: "Request")
        button.addTarget(self, action: #selector(btnPressed), for: .touchUpInside)
        requestBtn.addTarget(self, action: #selector(btnPressed), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        changeButtonFrame(button, frameY: view.frame.midY + wikiButton.frame.height / 2 + 8)
        changeButtonFrame(requestBtn, frameY: view.frame.midY - wikiButton.frame.height - 8)
    }
}
