//
//  Constants.swift
//  SugoiFridge
//
//  Created by Richard Hsu on 2020/3/8.
//  Copyright © 2020 TAR. All rights reserved.
//

import Foundation

enum Compartments : String {
    case Freezer
    case Fridge
    case Drawer
    
    static let allValues = [Freezer, Fridge, Drawer]
}

enum CustomUI : Int {
    case cornerRadius = 5
}

enum ErrorMessages : String {
    case generalTitle   = "Error"
    case searchTitle    = "Ingredient Error"
    case emptySearchMsg = "The ingredient name cannot be empty."
    case editTitle      = "Edit Error"
    case emptyMsg       = "Please fill in all information before continuing."
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
    case imageName
}

enum ImagePicker : String {
    case title = "Choose an Image"
    case camera = "Take Photo"
    case library = "Choose from Library"
    case cancel = "Cancel"
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

enum SegueIdentifiers : String {
    case fridgeSegue
    case editSegue
    case receiptSegue
}

enum SpoonacularAPI : String {
    case richAPIKey = "4a920a238fce46328d701af0ece929cf"
    case baseURL = "https://api.spoonacular.com"
    case autocomplete = "/food/ingredients/autocomplete"
    case parseIngredient = "/recipes/parseIngredients"
    case image = "https://spoonacular.com/cdn/ingredients_"
}
