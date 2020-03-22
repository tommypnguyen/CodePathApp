//
//  RecipeDetailsViewController.swift
//  SugoiFridge
//
//  Created by Tommy Nguyen on 3/9/20.
//  Copyright © 2020 TAR. All rights reserved.
//

import UIKit
import Alamofire

class RecipeDetailsViewController: UIViewController {
    @IBOutlet weak var backdropImage: UIImageView!
    
    @IBOutlet weak var recipeLabel: UILabel!
    
    @IBOutlet weak var ingredientsLabel: UILabel!
    
    @IBOutlet weak var stepsLabel: UITextView!
    
    var recipe: [String:Any]!
    var parameters2 = ["apiKey": "6b99189a3bf54d11aa2196d642496bac"]
    var parameters = ["apiKey": "6b99189a3bf54d11aa2196d642496bac", "ingredients": "apple,flour,sugar","number":"2"]
    var ingredientsArray:[String]!
    var instructionsArray:[String]!


    override func viewDidLoad() {
        super.viewDidLoad()

//         Do any additional setup after loading the view.
        recipeLabel.text = recipe["title"] as? String
        recipeLabel.layer.cornerRadius = 15;
        let imageUrl = URL(string: (recipe["image"] as? String)!)
        let data = try? Data(contentsOf: imageUrl!)
        if let imageData = data {
            backdropImage.image = UIImage(data: imageData)
        }
    
    }
    
    func getRecipe(recipeId: Int){
        var tempIngredientsArray = [String]()
        AF.request("https://api.spoonacular.com/recipes/\(recipeId)/information",method: .get, parameters: parameters2).validate().responseJSON { (response) in
            guard let ingredients = response.value else { return }
            if let tempArray = ingredients as? [String: AnyObject] {
                for ingredient in tempArray["extendedIngredients"] as! [AnyObject]  {
                    tempIngredientsArray.append((ingredient["name"] as! String).uppercased())

                }
                self.ingredientsArray = tempIngredientsArray
//                self.ingredientsLabel.text = self.ingredientsArray.joined(separator: "\n")
            }
        }
    }
    
    func getRecipeInstructions(recipeId: Int){
        var tempInstructionsArray = [String]()
               AF.request("https://api.spoonacular.com/recipes/\(recipeId)/analyzedInstructions",method: .get, parameters: parameters2).validate().responseJSON { (response) in
                   guard let ingredients = response.value else { return }
                   if let tempArray = ingredients as? [[String: AnyObject]] {
                       for ingredient in tempArray[0]["steps"] as! [AnyObject]  {
                           tempInstructionsArray.append(ingredient["step"] as! String)
                       }
                    var tempIngredientsArray = [String]()
                    AF.request("https://api.spoonacular.com/recipes/\(recipeId)/information",method: .get, parameters: self.parameters2).validate().responseJSON { (response) in
                                guard let ingredients = response.value else { return }
                                if let tempArray = ingredients as? [String: AnyObject] {
                                    for ingredient in tempArray["extendedIngredients"] as! [AnyObject]  {
                                        tempIngredientsArray.append(ingredient["name"] as! String)
                                    }
                                    self.ingredientsArray = tempIngredientsArray
                                    self.instructionsArray = tempInstructionsArray
                                    self.stepsLabel.text = "INGREDIENTS\n\n" + self.ingredientsArray.joined(separator: "\n\n") + "\n\nINSTRUCTIONS\n\n" + self.instructionsArray.joined(separator: "\n\n")
                                    self.stepsLabel.isEditable = false
                                }
                            }
                    
                   }
               }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getRecipe(recipeId: recipe["id"] as! Int)
        getRecipeInstructions(recipeId: recipe["id"] as! Int)

    }
    
  
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
