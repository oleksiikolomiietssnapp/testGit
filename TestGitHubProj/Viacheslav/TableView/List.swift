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
    var image: UIImage?
    
    init() {
        setup()
    }
    
    func setup() {
        
        for index in 0...7 {
            guard let image = UIImage(named: "img00\(index + 1)") else { return }
            let images = List(image: image, nameOfImage: "storm \(index + 1)")
            list.append(images)
        }
    }
}
