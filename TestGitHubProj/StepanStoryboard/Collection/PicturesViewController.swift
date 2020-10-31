//
//  PicturesViewController.swift
//  TestGitHubProj
//
//  Created by Stepan Niemykin on 28.10.2020.
//

import UIKit

private let reuseIdentifier = "Cell"

class PicturesViewController: UIViewController {
    private var images = [CollectionImage]()
    private var selectionIsEnabled = false
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollection()
        setImages()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setUpBarButtons()
    }
    
    func setUpCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.dragDelegate = self
        collectionView.dropDelegate = self
        collectionView.dragInteractionEnabled = true
        
        let nibCell = UINib(nibName: "PicturesCollectionViewCell", bundle: nil)
        
        collectionView.register(nibCell, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func setImages() {
        images = (0..<50).map { return CollectionImage(name: "icon\($0 + 1)") }
    }
    
    func setUpBarButtons() {
        let selectButton = UIBarButtonItem(title: "Select", style: .plain, target: self, action: #selector(selectButtonPressed))
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteButtonPressed))
        navigationItem.rightBarButtonItems = [selectButton, deleteButton]
    }
    
    @objc func selectButtonPressed() {
        if navigationItem.rightBarButtonItem?.title == "Select" {
            selectionIsEnabled = false
            navigationItem.rightBarButtonItem?.title = "Cancel"
        } else {
            selectionIsEnabled = true
            navigationItem.rightBarButtonItem?.title = "Select"
        }
        collectionView.reloadData()
    }
    
    @objc func deleteButtonPressed() {
    }
}
// MARK: - Collection View Delegate and Data Source
extension PicturesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PicturesCollectionViewCell else {
            return UICollectionViewCell()
        }
        let image = images[indexPath.row]
        
        cell.imageView.image = UIImage(named: image.name)
    
        return cell
    }
}
// MARK: - Collection View Flow Layout
extension PicturesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 15
        let cellPerRow: CGFloat = 3
        
        let cellWidth = (collectionView.bounds.width - (spacing * 2)) / cellPerRow
        
        return CGSize(width: cellWidth, height: cellWidth)
    }
}
// MARK: - Collection View Drag Delegate
extension PicturesViewController: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let item = images[indexPath.row].name
        let itemProvider = NSItemProvider(object: item as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = item
        
        return [dragItem]
    }
}
// MARK: - Collection View Drop Delegate
extension PicturesViewController: UICollectionViewDropDelegate {
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
                images.insert(CollectionImage(name: "\(item.dragItem.localObject ?? "")"), at: destination.item)
                collectionView.deleteItems(at: [sourceIndexPath])
                collectionView.insertItems(at: [destination])
            }
            coordinator.drop(item.dragItem, toItemAt: destination)
        }
    }
}
