//
//  SvitlanaDataBaseFirebaseViewController.swift
//  TestGitHubProj
//
//  Created by Svitlana Korostelova on 03.10.2020.
//

import Foundation
import UIKit

class SvitlanaDataBaseFirebaseViewController: UIViewController {
    //it will be button save
    @IBAction func runDataToFirebase(_ sender: UIButton) {
        // for reading, not to writing below (test)
        FirebaseService.readUsersFromDB(collectionName: "Users") { (users) in
            print(users)
        }
    }

}
