//
//  AnastasiiaCollectinViewController.swift
//  TestGitHubProj
//
//  Created by Anastasiia Spiridonova on 27.10.2020.
//

import UIKit

class AnastasiiaCollectinViewController: UIViewController {
    var isAbleToSelect = false
    let imageCount = 50
    var images = [AnastasiiaImage]()
    
    lazy var deleteBtn = { return UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteBtnPressed))}()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        images = (0..<imageCount).map { return AnastasiiaImage(name: "icon\($0 + 1)") }
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.dragDelegate = self
        collectionView.dropDelegate = self
        collectionView.dragInteractionEnabled = true
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        collectionView.register(UINib(nibName: "AnastasiiaCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AnastasiiaCollectionViewCell")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Select", style: .plain, target: self, action: #selector(selectBtnPressed))
        setToolbarItems([UIBarButtonItem(systemItem: .flexibleSpace), deleteBtn], animated: true)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.reloadData()
    }
    
    @objc func selectBtnPressed() {
        images.forEach { im in
            im.selected = false
        }
        deleteBtn.isEnabled = false
        self.isAbleToSelect.toggle()
        let title = navigationItem.rightBarButtonItem?.title
        if title == "Select" {
            navigationItem.rightBarButtonItem?.title = "Close"
            navigationController?.setToolbarHidden(false, animated: true)
        } else {
            navigationItem.rightBarButtonItem?.title = "Select"
            navigationController?.setToolbarHidden(true, animated: true)
        }
        collectionView.reloadData()
    }
    
    @objc func deleteBtnPressed() {
        images = images.filter { !$0.selected }
        collectionView.reloadData()
        selectBtnPressed()
    }
}

extension AnastasiiaCollectinViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnastasiiaCollectionViewCell", for: indexPath) as? AnastasiiaCollectionViewCell else {
            return UICollectionViewCell()
        }
        let image = images[indexPath.row]
        cell.imageView.image = UIImage(named: image.name)
        if isAbleToSelect {
            cell.imageView.alpha = image.selected ? 1 : 0.5
            cell.indicator.isHidden = !image.selected
        } else {
            cell.indicator.isHidden = true
            cell.imageView.alpha = 1
        }
        return cell
    }
}

extension AnastasiiaCollectinViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isAbleToSelect {
            let image = images[indexPath.row]
            image.selected.toggle()
            collectionView.reloadData()
        }
        var deleteIsEnabled = false
        for im in images where im.selected {
            deleteIsEnabled = true
            break
        }
        deleteBtn.isEnabled = deleteIsEnabled
    }
}

extension AnastasiiaCollectinViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellMaxWidth = (collectionView.frame.width - 32) / 3
        let cellWidth = 120 < cellMaxWidth ? 120 : cellMaxWidth
        return CGSize(width: cellWidth, height: cellWidth)
    }
}

extension AnastasiiaCollectinViewController: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let item = images[indexPath.row].name
        let itemProvider = NSItemProvider(object: item as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = item
        return [dragItem]
    }
}

extension AnastasiiaCollectinViewController: UICollectionViewDropDelegate {
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        var destinationIndexPath: IndexPath
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let row = collectionView.numberOfItems(inSection: 0) - 1
            destinationIndexPath = IndexPath(row: row, section: 0)
        }
        if coordinator.proposal.operation == .move {
            reorderItems(coordinator: coordinator, destination: destinationIndexPath, collectionView: collectionView)
        }
    }
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        if collectionView.hasActiveDrag {
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UICollectionViewDropProposal(operation: .forbidden)
    }
    
    fileprivate func reorderItems(coordinator: UICollectionViewDropCoordinator, destination: IndexPath, collectionView: UICollectionView) {
        if let item = coordinator.items.first,
           let sourceIndexPath = item.sourceIndexPath {
            collectionView.performBatchUpdates {
                images.remove(at: sourceIndexPath.item)
                collectionView.reloadData()
                images.insert(AnastasiiaImage(name: "\(item.dragItem.localObject ?? "")"), at: destination.item)
                collectionView.deleteItems(at: [sourceIndexPath])
                collectionView.insertItems(at: [destination])
            }
            coordinator.drop(item.dragItem, toItemAt: destination)
        }
    }
}
