//
//  NetworkingService.swift
//  TestGitHubProj
//
//  Created by Anastasiia Spiridonova on 05.10.2020.
//

import Foundation

class NetworkingService {
    static func request (url: URL, completitionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            completitionHandler(data, response, error)
        }
        
        task.resume()
    }
}
