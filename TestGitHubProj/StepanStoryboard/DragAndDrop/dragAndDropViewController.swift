//
//  dragAndDropViewController.swift
//  TestGitHubProj
//
//  Created by Stepan Niemykin on 10.10.2020.
//

import UIKit
import Foundation

class dragAndDropViewController: UIViewController {
    @IBOutlet weak var googleUrlLabel: UILabel!
    @IBOutlet weak var recognizerImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enableInteraction()
    }
    
    func enableInteraction() {
        let dragInteraction = UIDragInteraction(delegate: self)
        dragInteraction.isEnabled = true
        googleUrlLabel.addInteraction(dragInteraction)
        
        let dropInteraction = UIDropInteraction(delegate: self)
        recognizerImageView.addInteraction(dropInteraction)
        
        googleUrlLabel.isUserInteractionEnabled = true
        recognizerImageView.isUserInteractionEnabled = true
    }
}
extension dragAndDropViewController: UIDragInteractionDelegate {
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        guard let text = googleUrlLabel.text else { return [] }
        let provider = NSItemProvider(object: text as NSString)
              let item = UIDragItem(itemProvider: provider)
        item.localObject = text
        // Returning a non-empty array, as shown here, enables dragging.     // You can disable dragging by instead returning an empty array.
        print([item])
        return [item]
    }
}
extension dragAndDropViewController: UIDropInteractionDelegate {
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        print(session.items)
        session.loadObjects(ofClass: NSString.self, completion: { object in
            print(object)
        })
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        UIDropProposal(operation: .move)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSString.self)
    }
}
