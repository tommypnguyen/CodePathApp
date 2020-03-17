//
//  Protocols.swift
//  SugoiFridge
//
//  Created by Richard Hsu on 2020/3/17.
//  Copyright © 2020 TAR. All rights reserved.
//

import Foundation

protocol IngredientsDelegate {
    func updateIngredient(with newIngredient: Ingredient, at index: Int) 
}
