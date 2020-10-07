//
//  UsersModel.swift
//  TestGitHubProj
//
//  Created by Stepan Niemykin on 06.10.2020.
//

import Foundation

struct User: Codable {
    let name: String
    let age, count: Int
    
    init(name: String, age: Int, count: Int) {
        self.name = name
        self.age = age
        self.count = count
    }
}
