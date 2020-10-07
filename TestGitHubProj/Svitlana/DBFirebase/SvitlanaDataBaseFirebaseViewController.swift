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
        let countValue = Int(count.text!)
        let ageValue = Int(age.text!)
        let nameValue = name.text!
        FirebaseService.addDataToDB(collectionName: "Users", dictionaryData: ["name" : nameValue, "age" : ageValue!, "count": countValue!])
        
//                FirebaseService.readUsersFromDB(callback: { users in
//                    print(users)
//                })
//
        
        //        FirebaseService.readUsersFromDB { (users) in
        //            print(users)
        //        }
    }


        

    

}
