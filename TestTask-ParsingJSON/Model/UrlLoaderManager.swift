//
//  UrlLoaderManager.swift
//  TestTask-ParsingJSON
//
//  Created by Vladimir Sharaev on 13.07.2020.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//

import Foundation

class UrlLoaderManager {
    
    static var shared = UrlLoaderManager()
    lazy var configuration: URLSessionConfiguration = URLSessionConfiguration.default
    lazy var session: URLSession = URLSession(configuration: self.configuration)
    
    func downloadImage(url: URL, completion: @escaping((Data) -> Void)) {
        let request = URLRequest(url: url)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                if let httpResponse = response as? HTTPURLResponse {
                    switch (httpResponse.statusCode) {
                    case 200:
                        if let data = data {
                            completion(data)
                        }
                    default:
                            print(httpResponse.statusCode)
                    }
                }
            } else {
                print("Error donwload data \(error!.localizedDescription)")
            }
        }
        dataTask.resume()
        
    }
}
