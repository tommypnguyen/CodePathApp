//
//  StringCapitalization.swift
//  SugoiFridge
//
//  Created by Richard Hsu on 2020/3/22.
//  Copyright © 2020 TAR. All rights reserved.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizeFirstLetter()
    }
}
