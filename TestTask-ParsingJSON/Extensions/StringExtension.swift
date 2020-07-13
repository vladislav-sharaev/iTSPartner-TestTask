//
//  StringExtension.swift
//  TestTask-ParsingJSON
//
//  Created by Vladimir Sharaev on 13.07.2020.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//

import Foundation

extension String {
    func localized(tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, bundle: Bundle.main, value: "***\(self)***", comment: "")
    }
}
