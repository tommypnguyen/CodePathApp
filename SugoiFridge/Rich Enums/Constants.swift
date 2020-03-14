//
//  Constants.swift
//  SugoiFridge
//
//  Created by Richard Hsu on 2020/3/8.
//  Copyright © 2020 TAR. All rights reserved.
//

import Foundation

enum CustomUI : Int {
    case cornerRadius = 5
}

enum ReuseIdentifiers : String {
    case inputTableView = "IngredientTableViewCell"
    case newIngTableView = "NewIngredientTableViewCell"
}

enum SpoonacularAPI : String {
    case ingredientInfo = "https://api.spoonacular.com/food/ingredients/%d/information"
}
