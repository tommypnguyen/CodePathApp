//
//  Structs.swift
//  SugoiFridge
//
//  Created by Richard Hsu on 2020/3/14.
//  Copyright © 2020 TAR. All rights reserved.
//

import Foundation

struct Ingredient {
    let id     : Int
    let name   : String
    let image  : String
    let unit   : String
    let amount : Double
    let aisle  : String
    let possibleUnits : [String]
    let cost : [String : Any]
}
