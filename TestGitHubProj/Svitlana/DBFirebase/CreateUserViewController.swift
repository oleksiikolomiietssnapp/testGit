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
        if let dataName = name.text,
           let dataCount = count.text,
           let dataAge = age.text {
            if !dataName.isEmpty && !dataCount.isEmpty && !dataAge.isEmpty {
                guard let countValue = Int(dataCount) else { print("fill numeric symbols into count field")
                    return }
                guard let ageValue = Int(dataAge) else { print("fill numeric symbols into age field")
                    return }
                var user = User(name: dataName, age: ageValue, count: countValue)
                if userPhoto.image != UIImage(named: "userPhotoTemplate") {
                    user.image = userPhoto.image?.jpegData(compressionQuality: 100.0)
                }
                FirebaseService.saveUser(user)
            } else {
                print("fill all fields please")
                return
            }
            dismiss(animated: true, completion: nil)
        } else {
            print("unexpected nil")
            return
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            userPhoto.contentMode = .scaleAspectFit
            userPhoto.image = pickedImage
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
}
