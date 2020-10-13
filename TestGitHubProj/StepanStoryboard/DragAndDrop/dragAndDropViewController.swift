//
//  dragAndDropViewController.swift
//  TestGitHubProj
//
//  Created by Stepan Niemykin on 10.10.2020.
//

import UIKit
import Foundation
import SafariServices

class dragAndDropViewController: UIViewController {
    @IBOutlet weak var googleUrlLabel: UILabel!
    @IBOutlet weak var recognizerImageView: UIImageView!
    @IBOutlet weak var intitaLabel: UILabel!
    @IBOutlet weak var goButton: UIButton!
    
    @IBAction func visitSiteButtonPressed(_ sender: UIButton) {
        guard let url = url else { return }
        showSafari(url)
    }
    
    var receivedText: String?
    var url: String?
    
    let google = "GOOGLE"
    let intita = "INTITA"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enableInteraction()
    }
    
    override func viewWillLayoutSubviews() {
        setupUI()
    }
    
    func enableInteraction() {
        //drag
        let dragInteractionGoogle = UIDragInteraction(delegate: self)
        let dragInteractionITA = UIDragInteraction(delegate: self)
        dragInteractionGoogle.isEnabled = true
        dragInteractionITA.isEnabled = true
        googleUrlLabel.addInteraction(dragInteractionGoogle)
        intitaLabel.addInteraction(dragInteractionITA)
        //drop
        let dropInteraction = UIDropInteraction(delegate: self)
        recognizerImageView.addInteraction(dropInteraction)
        //enabling interaction
        googleUrlLabel.isUserInteractionEnabled = true
        recognizerImageView.isUserInteractionEnabled = true
        intitaLabel.isUserInteractionEnabled = true
    }
    
    func configureURL() {
        switch receivedText {
        case google:
            url = "https://www.google.com.ua/?client=safari"
            recognizerImageView.image = UIImage(named: "googleIcon")
        case intita:
            url = "https://intita.com"
            recognizerImageView.image = UIImage(named: "ITAIcon")
        default:
            print("OLALALALALALALLA")
        }
    }
    
    func showSafari(_ url: String) {
        guard let url = URL(string: url) else { return }
        
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
    }
    
    func setupUI() {
        goButton.layer.cornerRadius = 10.0
        googleUrlLabel.layer.cornerRadius = 10.0
        intitaLabel.layer.cornerRadius = 10.0
        recognizerImageView.layer.cornerRadius = 10.0
    }
}
extension dragAndDropViewController: UIDragInteractionDelegate {
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        var tag: Int?
        var text = ""
        
        if session.location(in: self.googleUrlLabel).y < googleUrlLabel.frame.maxY {
            tag = googleUrlLabel.tag
        } else if session.location(in: self.intitaLabel).y < intitaLabel.frame.maxY {
            tag = intitaLabel.tag
        }
        
        guard let labelTag = tag else { return [] }
        
        switch labelTag {
        case 1:
            text = google
        case 2:
            text = intita
        default:
            print("wrong label was taken!")
        }
        
        let provider = NSItemProvider(object: text as NSString)
              let item = UIDragItem(itemProvider: provider)
        item.localObject = text
        // Returning a non-empty array, as shown here, enables dragging.     // You can disable dragging by instead returning an empty array.
        return [item]
    }
}
extension dragAndDropViewController: UIDropInteractionDelegate {
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        session.loadObjects(ofClass: NSString.self, completion: { object in
            guard let item = object.first, let string = item as? String else { return }
            self.receivedText = string
            
            DispatchQueue.main.async {
                self.configureURL()
            }
        })
        goButton.backgroundColor = UIColor.red
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        UIDropProposal(operation: .move)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSString.self)
    }
}
