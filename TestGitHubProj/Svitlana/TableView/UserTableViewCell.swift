//
//  UserTableViewCell.swift
//  TestGitHubProj
//
//  Created by Svitlana Korostelova on 14.10.2020.
//

import UIKit
import Firebase
import FirebaseUI

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var userCount: UILabel!
    @IBOutlet weak var userAge: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userPhoto: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userPhoto.image = UIImage(named: "userPhotoTemplate.jpg")
    }
    
    func configure(with user: User) {
        userName.text = user.name
        userAge.text = String(user.age)
        userCount.text = String(user.count)
        // MARK: Option 1
        FirebaseService.downloadUserImageFromDB(id: user.documentID) { [weak self] (image) in
            self?.userPhoto.image = image
        }
    }    
}
