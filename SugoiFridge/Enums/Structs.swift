//
//  Structs.swift
//  SugoiFridge
//
//  Created by Richard Hsu on 2020/3/14.
//  Copyright © 2020 TAR. All rights reserved.
//

import UIKit
import Foundation

struct Ingredient {
    let id     : Int
    let name   : String
    let image  : UIImage
    let imageName : String
    let unit   : String
    let amount : Double
    let aisle  : String
    let cost   : [String : Any]
    let compartment   : String = "Fridge"
    let possibleUnits : [String]
}
