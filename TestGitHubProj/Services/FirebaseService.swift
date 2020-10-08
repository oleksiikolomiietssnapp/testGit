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
    
    /// Add a new document with own ID
    class func addDataToDB(collectionName: String, documentName: String, dictionaryData: [String:Any]) {
        db.collection(collectionName).document(documentName).setData(dictionaryData)
        db.collection(collectionName).document(documentName).updateData([
            "lastUpdated": FieldValue.serverTimestamp(), //by whom (username)
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
            "lastUpdated": FieldValue.serverTimestamp(), //by whom (username)
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
        db.collection(collectionName).getDocuments() { (querySnapshot, err) in
            var names = [String]()
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let name = document.get("name") as! String
                    names.append(name)
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
    
    /// Get data from collection "Users"
    class func readUsersFromDB(callback: @escaping ([User]) -> Void) {
        db.collection("Users").getDocuments() { (querySnapshot, err) in
            var users: [User] = []
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                guard let documents = querySnapshot?.documents else {
                    print("Empty response")
                    return
                }
                for document in documents {
                    let parsedData = document.data()
                    var user = User(name: "", age: 0, count: 0)
                    for (key, value) in parsedData {
                        if key == "name"{
                            user.name = value as! String
                        }
                        if key == "age"{
                            user.age = value as! Int
                        }
                        if key == "count"{
                            user.count = value as! Int
                        }
                    }
                    users.append(user)
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
        }
    }
    
    /// Get multiple documents from a collection by selected value
    class func selectDataFromDBbyValue (collectionName: String, fieldName: String, value: Any) {
        db.collection(collectionName).whereField(fieldName, isEqualTo: value)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                    }
                }
            }
    }
}
