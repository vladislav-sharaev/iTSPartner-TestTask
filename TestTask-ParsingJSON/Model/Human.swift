//
//  Human.swift
//  TestTask-ParsingJSON
//
//  Created by Vladimir Sharaev on 13.07.2020.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//

import Foundation
import UIKit

struct Human: Decodable {
    let index: Int?
    let _id: String?
    let name: String?
    let picture: String?
    let gender: Gender?
    let age: Int?
    let eyeColor: String?
    let favoriteFruit: String?
    let balance: String?
    let guid: String?
    let isActive: Bool?
}

// String, Decodable
enum Gender: Decodable {
    case male
    case female
    case unknown
    
    init(from decoder: Decoder) throws {
        let str = try decoder.singleValueContainer().decode(String.self)
        switch str {
            case "male": self = .male
            case "female": self = .female
            default: self = .unknown
        }
    }
}
