//
//  FirebaseViewController.swift
//  TestGitHubProj
//
//  Created by Stepan Niemykin on 02.10.2020.
//

import UIKit
import Firebase

class FirebaseViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var centralStackView: UIStackView!
    
    var email: String?
    var password: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        centralStackView.layer.borderWidth = 10
        centralStackView.layer.borderColor = UIColor.red.cgColor
    }
    
    @IBAction func createNewUser(_ sender: UIButton) {

        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    print("Error: \(error)")
                } else {
                    self.resultLabel.text = "You have created a new user!"
                }
            }
        }
        clearTextFields()
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
              guard let strongSelf = self else { return }
                if let error = error {
                    print("ОШИБКА ЕМАЕ \(error)")
                    self!.resultLabel.text = "Wrong password or email!"
                } else {
                    self!.resultLabel.text = "Success"
                }
            }
        }
        clearTextFields()
    }
    
    func clearTextFields() {
        emailTextField.text = ""
        passwordTextField.text = ""
    }

}
