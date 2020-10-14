//
//  CreateUserViewController.swift
//  TestGitHubProj
//
//  Created by Svitlana Korostelova on 03.10.2020.
//

import Foundation
import UIKit

class CreateUserViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet weak var count: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var userPhoto: UIImageView!
    
    let imagePicker = UIImagePickerController()
    private var urlOfCurrentUserPhoto: URL?
    private var idOfCurrentUserPhoto: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        userPhoto.image = UIImage(named: "userPhotoTemplate")
    }
    
    @IBAction func save(_ sender: UIButton) {
        if let dataName = name.text, let dataCount = count.text, let dataAge = age.text {
            if !dataName.isEmpty && !dataCount.isEmpty && !dataAge.isEmpty {
                guard let countValue = Int(dataCount) else { print("fill numeric symbols into count field")
                    return }
                guard let ageValue = Int(dataAge) else { print("fill numeric symbols into age field")
                    return }
                let user = User(name: dataName, age: ageValue, count: countValue, photo: urlOfCurrentUserPhoto)
                if userPhoto.image == nil {
                    FirebaseService.addDataToDB(collectionName: "Users", documentName: user.documentID, dictionaryData: ["name" : user.name, "age" : user.age, "count": countValue, "userPhotoId": "not_loaded", "photoURL" : "not_loaded"] )
                } else {
                    FirebaseService.addDataToDB(collectionName: "Users", documentName: user.documentID, dictionaryData: ["name" : user.name, "age" : user.age, "count": countValue, "userPhotoId": "\(idOfCurrentUserPhoto)", "photoURL" : "\(user.photo!)" ] )
                }
            } else {
                print("fill all fields please")
                return
            }
        } else {
            print("unexpected nil")
            return
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            userPhoto.contentMode = .scaleAspectFit
            userPhoto.image = pickedImage
            addToDB(selectedImg: pickedImage)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func uploadImg(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func addToDB(selectedImg: UIImage) {
        FirebaseService.uploadUserImageToDB(image: selectedImg) { [weak self] url, id in
            self?.urlOfCurrentUserPhoto = url
            self?.idOfCurrentUserPhoto = id
            print("User photo was added to Firebase with ID: \(id)")
        }
    }
}
