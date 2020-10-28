//
//  AnastasiaViewController.swift
//  TestGitHubProj
//
//  Created by Anastasiia Spiridonova on 28.09.2020.
//

import UIKit
import SafariServices

class AnastasiaViewController: UIViewController, SFSafariViewControllerDelegate {
    
    private let kWikiUrl = "https://www.wikipedia.org"
    
    lazy private var  textBtn = { return UIButton(type: .custom) }()
    
    lazy private var requestBtn = { return UIButton(type: .custom) }()
    
    lazy private var firebaseBtn = { return UIButton(type: .custom) }()
    
    lazy private var animationBtn = { return UIButton(type: .custom) }()
    lazy private var collectionViewBtn = { return UIButton(type: .custom) }()
    
    @IBOutlet private var textViewController: UIView!
    
    @IBOutlet weak private var wikiButton: UIButton!
    
    @IBAction private func wikiBtnPressed(_ sender: UIButton) {
            showSafari(kWikiUrl)
    }
    
    @objc private func textBtnPressed() {
            self.navigationController?.pushViewController(TextViewController(), animated: true)
    }
    
    @objc private func requestBtnPressed() {
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
    
    @objc private func firebaseBtnPressed() {
        DispatchQueue.main.async {
            FirebaseService.readUsersFromDB(callback: {users in
                self.navigationController?.pushViewController(FirebaseUsersViewController(users: users), animated: true)
            })
        }
    }
    
    @objc private func animationBtnPressed() {
        let storyboard = UIStoryboard(name: "AnastasiiaAnimationStoryboard", bundle: .main)
        guard let vc = storyboard.instantiateViewController(identifier: "animationStoryboard") as? AnastasiiaAnimationViewController else {
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    @objc private func collectionViewBtnPressed() {
        let storyboard = UIStoryboard(name: "AnastasiiaCollectionView", bundle: .main)
                 guard let vc = storyboard.instantiateViewController(identifier: "anastasiiaCVC") as? AnastasiiaCollectinViewController else {
                     return
                 }
        navigationController?.pushViewController(vc, animated: true)
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
        button.frame = CGRect(x: wikiButton.frame.minX, y: frameY, width: wikiButton.frame.width, height: wikiButton.frame.height)
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
        addButton(firebaseBtn)
        addButton(textBtn)
        addButton(requestBtn)
        addButton(animationBtn)
        customizeBtn(textBtn, frameY: wikiButton.frame.maxY + 8, title: "Text")
        customizeBtn(requestBtn, frameY: wikiButton.frame.minY -  wikiButton.frame.height - 8, title: "Request")
        customizeBtn(firebaseBtn, frameY: textBtn.frame.maxY + 8, title: "Firebase")
        customizeBtn(animationBtn, frameY: requestBtn.frame.minY - requestBtn.frame.height - 8, title: "Animation")
        addButton(collectionViewBtn)
        customizeBtn(textBtn, frameY: view.frame.midY + wikiButton.frame.height / 2 + 8, title: "Text")
        customizeBtn(requestBtn, frameY: view.frame.midY - wikiButton.frame.height * 1.5 - 8, title: "Request")
        customizeBtn(firebaseBtn, frameY: view.frame.midY + wikiButton.frame.height * 1.5 + 16, title: "Firebase")
        customizeBtn(collectionViewBtn, frameY: view.frame.midY + wikiButton.frame.height * 2.5 + 24, title: "Collection View")
        textBtn.addTarget(self, action: #selector(textBtnPressed), for: .touchUpInside)
        requestBtn.addTarget(self, action: #selector(requestBtnPressed), for: .touchUpInside)
        firebaseBtn.addTarget(self, action: #selector(firebaseBtnPressed), for: .touchUpInside)
        animationBtn.addTarget(self, action: #selector(animationBtnPressed), for: .touchUpInside)
        collectionViewBtn.addTarget(self, action: #selector(collectionViewBtnPressed), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        changeButtonFrame(textBtn, frameY: wikiButton.frame.maxY + 8)
        changeButtonFrame(requestBtn, frameY: wikiButton.frame.minY -  wikiButton.frame.height - 8)
        changeButtonFrame(firebaseBtn, frameY: textBtn.frame.maxY + 8)
        changeButtonFrame(animationBtn, frameY: requestBtn.frame.minY - requestBtn.frame.height - 8)
        changeButtonFrame(textBtn, frameY: view.frame.midY + wikiButton.frame.height / 2 + 8)
        changeButtonFrame(requestBtn, frameY: view.frame.midY - wikiButton.frame.height * 1.5 - 8)
        changeButtonFrame(firebaseBtn, frameY: view.frame.midY + wikiButton.frame.height * 1.5 + 16)
        changeButtonFrame(collectionViewBtn, frameY: view.frame.midY + wikiButton.frame.height * 2.5 + 24)
    }
}
