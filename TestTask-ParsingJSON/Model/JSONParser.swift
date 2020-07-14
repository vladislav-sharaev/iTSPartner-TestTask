//
//  JSONParser.swift
//  TestTask-ParsingJSON
//
//  Created by Vladimir Sharaev on 13.07.2020.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//

import Foundation

class JSONParser {
    func parseJson(jsonUrlString: String, completion: @escaping((Result<[Human], NetworkError>) -> Void)) {
        guard let url = URL(string: jsonUrlString) else {
            completion(.failure(.badURL))
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print("Error data: ", error.debugDescription)
                completion(.failure(.requestFailed))
                return
            }
            do {
                let humans = try JSONDecoder().decode([Human].self, from: data)
                completion(.success(humans))
                
            } catch let jsonError {
                print("Eror with json:", jsonError)
                completion(.failure(.unknown))
            }
        }.resume()
    }
}
