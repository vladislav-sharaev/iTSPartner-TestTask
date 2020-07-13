//
//  JSONParser.swift
//  TestTask-ParsingJSON
//
//  Created by Vladimir Sharaev on 13.07.2020.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//

import Foundation

class JSONParser {
    func parseJson(jsonUrlString: String, completion: @escaping(([Human]) -> Void)) {
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print("Error data")
                return
            }
            
            do {
                let humans = try JSONDecoder().decode([Human].self, from: data)
                completion(humans)
                
            } catch let jsonError {
                print("Eror with json:", jsonError)
            }
        }.resume()
    }
}
