//
//  SvitlanaDataBaseFirebaseViewController.swift
//  TestGitHubProj
//
//  Created by Svitlana Korostelova on 03.10.2020.
//

import Foundation
import UIKit

class SvitlanaDataBaseFirebaseViewController: UIViewController {
    func showUsers(users: [User]) {
        textView.text = "\(users)"
    }
    @IBOutlet weak var textView: UITextView!
    //it will be button save
    @IBAction func runDataToFirebase(_ sender: UIButton) {
        // for reading, not to writing below (test)
        FirebaseService.readUsersFromDB(callback: { users in
            print(users)
            self.textView.text = "\(users)"
        })
//        FirebaseService.readDataFromDB(collectionName: "Users", documentName: "AH-34")
    }

}
