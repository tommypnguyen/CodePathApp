//
//  ParseAPI.swift
//  SugoiFridge
//
//  Created by Richard Hsu on 2020/3/18.
//  Copyright © 2020 TAR. All rights reserved.
//

import Parse
import Foundation

class ParseCaller {
    static let client = ParseCaller()
    
    func toUpdateIngredient(inVC vc: UIViewController, with ingredient: Ingredient) {
        let query = PFQuery(className: FoodDB.className.rawValue)
        query.whereKey(FoodDB.user.rawValue, equalTo: PFUser.current()!)
        query.whereKey(FoodDB.foodID.rawValue, equalTo: ingredient.id)
        query.whereKey(FoodDB.unit.rawValue, equalTo: ingredient.unit)
        
        query.getFirstObjectInBackground { (food: PFObject?, error: Error?) in
            if let error = error {
                print("Error obtaining previous records for \"\(ingredient.name)\":\n \(error.localizedDescription)")

                // Just add it as a new entry
                self.saveIngredient(inVC: vc, with: ingredient)
            }
            else if let food = food {
                self.updateIngredient(inVC: vc, update: food, with: ingredient)
            }
        }
    }
    
    func saveIngredient(inVC vc: UIViewController, with ingredient: Ingredient) {
        // Get table on parse to save foods in
        let food = PFObject(className: FoodDB.className.rawValue)
        
        food[FoodDB.user.rawValue]          = PFUser.current()!
        food[FoodDB.foodID.rawValue]        = ingredient.id
        food[FoodDB.foodName.rawValue]      = ingredient.name
        food[FoodDB.compartment.rawValue]   = ingredient.compartment
        food[FoodDB.aisle.rawValue]         = ingredient.aisle
        food[FoodDB.quantity.rawValue]      = ingredient.amount
        food[FoodDB.unit.rawValue]          = ingredient.unit
        food[FoodDB.possibleUnits.rawValue] = ingredient.possibleUnits
        food[FoodDB.imageName.rawValue]     = ingredient.imageName
        
        // Load image into Parse Object
        if let imageData = ingredient.image.pngData() {
            let file = PFFileObject(name: "image.png", data: imageData)
            food[FoodDB.image.rawValue] = file
        }
        
        // Save new food ingredient parse object onto the database
        food.saveInBackground { (success, error) in
            if success {
                print("Ingredient \(ingredient.name) saved successfully to parse\n")
            }
            else {
                print("Error when saving \(ingredient.name) to Parse:\n\(error!.localizedDescription)")
                AlertControl.control.displayAlert(inVC: vc, withTitle: ErrorMessages.generalTitle.rawValue, andMsg: "Error when saving \(ingredient.name) to server! Please try again later.")
            }
        }
    }
    
    func updateIngredient(inVC vc: UIViewController, update food: PFObject, with ingredient: Ingredient) {
        food[FoodDB.user.rawValue]          = PFUser.current()!
        food[FoodDB.foodID.rawValue]        = ingredient.id
        food[FoodDB.foodName.rawValue]      = ingredient.name
        food[FoodDB.compartment.rawValue]   = ingredient.compartment
        food[FoodDB.aisle.rawValue]         = ingredient.aisle
        food[FoodDB.unit.rawValue]          = ingredient.unit
        food[FoodDB.possibleUnits.rawValue] = ingredient.possibleUnits
        food[FoodDB.imageName.rawValue]     = ingredient.imageName
        
        food[FoodDB.quantity.rawValue] = food[FoodDB.quantity.rawValue] as! Double + ingredient.amount
        
        food.saveInBackground { (success, error) in
            if success {
                print("Ingredient \(ingredient.name) updated successfully to parse\n")
            }
            else {
                print("Error when updating \(ingredient.name) to Parse:\n\(error!.localizedDescription)")
                AlertControl.control.displayAlert(inVC: vc, withTitle: ErrorMessages.generalTitle.rawValue, andMsg: "Error when saving \(ingredient.name) to server! Please try again later.")
            }
        }
    }
}
