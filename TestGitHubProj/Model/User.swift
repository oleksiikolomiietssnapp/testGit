//  User.swift
//  TestGitHubProj
//
//  Created by Anastasiia Spiridonova on 05.10.2020.

import Foundation

struct User: Codable {
    let name: String
    let age, count: Int
    var image: Data?
    let documentID: String
    
    init(name: String, age: Int, count: Int, documentID: String? = nil) {
        self.name = name
        self.age = age
        self.count = count
        if let id = documentID {
            self.documentID = id
        } else {
            self.documentID = UUID().uuidString
        }
    }
}
