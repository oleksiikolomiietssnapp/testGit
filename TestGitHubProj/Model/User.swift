//
//  User.swift
//  TestGitHubProj
//
//  Created by Anastasiia Spiridonova on 05.10.2020.
//

struct User: Codable {
    let name: String
    let age, count: Int
    
    init(name: String, age: Int, count: Int) {
        self.name = name
        self.age = age
        self.count = count
    }
}
