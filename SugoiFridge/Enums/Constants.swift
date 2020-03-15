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

enum FoodDB : String {
    case className = "Food"
    case user = "userID"
    case foodID
    case foodName
    case compartment
    case aisle
    case quantity
    case unit
    case possibleUnits
    case image
}

enum ImageSize : String {
    case small  = "100x100"
    case medium = "250x250"
    case large  = "500x500"
}

enum ReuseIdentifiers : String {
    case inputTableView = "IngredientTableViewCell"
    case newIngTableView = "NewIngredientTableViewCell"
}

enum SpoonacularAPI : String {
    case richAPIKey = "4a920a238fce46328d701af0ece929cf"
    case baseURL = "https://api.spoonacular.com"
    case autocomplete = "/food/ingredients/autocomplete"
    case parseIngredient = "/recipes/parseIngredients"
    case image = "https://spoonacular.com/cdn/ingredients_"
}
