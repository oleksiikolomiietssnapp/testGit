//
//  SvitlanaDataBaseFirebaseViewController.swift
//  TestGitHubProj
//
//  Created by Svitlana Korostelova on 03.10.2020.
//

import Foundation
import UIKit

class SvitlanaDataBaseFirebaseViewController: UIViewController {
    @IBOutlet weak var count: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var age: UITextField!
    private var urlValue = ""
    
    @IBAction func save(_ sender: UIButton) {
        if let dataName = name.text, let dataCount = count.text, let dataAge = age.text {
            if !dataName.isEmpty && !dataCount.isEmpty && !dataAge.isEmpty {
                guard let countValue = Int(dataCount) else { print("fill numeric symbols into count field")
                    return }
                guard let ageValue = Int(dataAge) else { print("fill numeric symbols into age field")
                    return }
                FirebaseService.addDataToDB(collectionName: "Users", dictionaryData: ["name" : dataName, "age" : ageValue, "count": countValue])
            } else {
                print("fill all fields please")
                return
            }
        } else {
            print("unexpected nil")
            return
        }
    }
    
    @IBAction func uploadImg(_ sender: UIButton) {
        guard let currentImg = UIImage(named: "avatar") else {return}
        FirebaseService.uploadUserImageToDB(image: currentImg) { [weak self] url in
            self?.urlValue = "\(url)"
            FirebaseService.updateDataToDB(collectionName: "Users", documentName: "JNUYliBO4e4wsT5ILioG", fieldName: "avatar", value: self?.urlValue)
            }
        print(urlValue)
    }
}
