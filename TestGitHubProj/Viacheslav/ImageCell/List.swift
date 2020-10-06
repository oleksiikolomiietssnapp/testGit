//
//  List.swift
//  TestGitHubProj
//
//  Created by Viacheslav Markov on 06.10.2020.
//

import Foundation
import  UIKit

struct List {
    var image: UIImage
    var nameOfImage: String
}

class ListImages {
    
    var list = [List]()
    
    init() {
        setup()
    }
    
    func setup() {
        
        for index in 1...8 {
            guard let image = UIImage(named: "img00\(index)") else { return }
            let images = List(image: image, nameOfImage: "storm \(index)")
            list.append(images)
        }
    }
}
