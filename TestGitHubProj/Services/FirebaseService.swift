//
//  FirebaseService.swift
//  TestGitHubProj
//
//  Created by Svitlana Korostelova on 04.10.2020.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseFirestore

final class FirebaseService {
    private static let db = Firestore.firestore()
    static let storageRef = Storage.storage().reference()
    
    /// MAIN WAY TO SAVE DATA
    class func saveUser(_ user: User) {
        // Save user to cloud
        addDataToDB(
            collectionName: "Users",
            documentName: user.documentID,
            dictionaryData: [
                "name" : user.name,
                "age" : user.age,
                "count": user.count
            ])
        // Save image to storage with the same Id as user have
        if let image = user.image {
            uploadUserImageToDB(image: image, id: user.documentID)
        }
    }
    /// Uploading users image into DB, creating URL for it
    class func uploadUserImageToDB(image: Data, id: String) {
        let fileRef = storageRef.child("images/\(id).jpg")
        _ = fileRef.putData(image, metadata: nil) { (metadata, error) in
            guard metadata != nil else {
                print("Error: \(error?.localizedDescription ?? "Uh-oh, an error occurred!")")
                return
            }
        }
    }
    
    class func removeUserImageFromDB(id: String) {
        let fileRef = storageRef.child("images/\(id).jpg")
        fileRef.delete { error in
            guard let error = error else { return }
            print("Error: \(error.localizedDescription)")
        }
    }
    
    // MAIN WAY TO READ DATA
    class func downloadUserImageFromDB(
        id: String,
        callback: @escaping (UIImage) -> Void) {
        let islandRef = storageRef.child("images/\(id).jpg")

        islandRef.getData(maxSize: 100 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                guard let data = data,
                      let image = UIImage(data: data) else {return}
                
                callback(image)
            }
        }
    }
    
    /// Add a new document with own user ID
    class func addDataToDB(
        collectionName: String,
        documentName: String = UUID().uuidString,
        dictionaryData: [String:Any]) {
        db.collection(collectionName).document(documentName).setData(dictionaryData)
        db.collection(collectionName).document(documentName).updateData([
            "lastUpdated": FieldValue.serverTimestamp() //by whom (username)
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document \(documentName) successfully added")
            }
        }
    }
    
    /// Add a new document with a generated ID-document
    class func addDataToDB(collectionName: String, dictionaryData: [String:Any]) -> String? {
        var ref: DocumentReference?
        
        ref = db.collection(collectionName).addDocument(data: dictionaryData) { err in
            if let err = err {
                print("Error adding document: \(err)")
            }
        }
        if let unwrapRef = ref {
            print("Document added with ID: \(unwrapRef.documentID)")
            return unwrapRef.documentID
        }
        return nil
    }
    
    /// Update one field, creating the document if it does not exist, creating the field if it does not exist
    class func updateDataToDB(collectionName: String, documentName: String, fieldName: String, value: Any) {
        db.collection(collectionName).document(documentName).setData([ fieldName: value ], merge: true)
        db.collection(collectionName).document(documentName).updateData([
            "lastUpdated": FieldValue.serverTimestamp() //by whom (username)
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document \(documentName) successfully updated")
            }
        }
    }
    
    /// Get all documents in a collection
    class func readDataFromDB(collectionName: String) {
        db.collection(collectionName).getDocuments { (querySnapshot, err) in
            var names = [String]()
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let name = document.get("name") as? String
                    names.append(name ?? "")
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
    
    /// Get data from collection "Users"
    class func readUsersFromDB(callback: @escaping ([User]) -> Void) {
        db.collection("Users").getDocuments { (querySnapshot, err) in
            var users = [User]()
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                guard let documents = querySnapshot?.documents else {
                    print("Empty response")
                    return
                }
                for document in documents {
                    let parsedData = document.data()
                    guard let name = parsedData["name"] as? String,
                          let age = parsedData["age"] as? Int,
                          let count = parsedData["count"] as? Int else {
                        continue
                    }
                    users.append(User(name: name, age: age, count: count, documentID: document.documentID))
                }
            }
            callback(users)
        }
    }
    
    /// Retrieve the contents of a single document
    class func readDataFromDB(collectionName: String, documentName: String) {
        let docRef = db.collection(collectionName).document(documentName)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist")
            }
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    /// Get multiple documents from a collection by selected value
    class func selectDataFromDBbyValue (collectionName: String, fieldName: String, value: Any) {
        db.collection(collectionName).whereField(fieldName, isEqualTo: value)
            .getDocuments { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                    }
                }
            }
    }
    
    // MARK: Option 2
    func showImageInView(){
//        let reference = storageRef.child("images/\(user.documentID).jpg")

        // UIImageView in your ViewController
//        let imageView: UIImageView = self.userPhoto
        // Placeholder image
        let placeholderImage = UIImage(named: "userPhotoTemplate.jpg")
        // Load the image using SDWebImage
//        imageView.sd_setImage(with: reference, placeholderImage: placeholderImage)
    }
}
