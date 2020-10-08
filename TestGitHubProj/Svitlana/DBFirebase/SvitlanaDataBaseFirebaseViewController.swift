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
}
