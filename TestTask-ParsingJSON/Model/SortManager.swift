//
//  SortManager.swift
//  TestTask-ParsingJSON
//
//  Created by Vladimir Sharaev on 13.07.2020.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//

import Foundation

class SortManager {
    
    func sortByDecrease(array: [Human]) -> [Human] {
        let sortedArray = array.sorted(by: { $0.age ?? 0 > $1.age ?? 0 })
        return sortedArray
    }
    
    func sortByIncrease(array: [Human]) -> [Human] {
        let sortedArray = array.sorted(by: { $0.age ?? 0 < $1.age ?? 0 })
        return sortedArray
    }
    
    func sortByGender(gender: Gender, array: [Human]) -> [Human] {
        var newArray = [Human]()
        for element in array {
            if element.gender == gender {
                newArray.append(element)
            }
        }
        return newArray
    }
}
