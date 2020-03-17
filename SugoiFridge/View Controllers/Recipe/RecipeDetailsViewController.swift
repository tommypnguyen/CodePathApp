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
    @IBOutlet weak var stepsLabel: UILabel!
    var recipe: [String:Any]!
    var parameters = ["apiKey": "6b99189a3bf54d11aa2196d642496bac"]
    var ingredientsArray:[String]!
    var instructionsArray:[String]!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        recipeLabel.text = recipe["title"] as? String
        recipeLabel.layer.cornerRadius = 15;
        let imageUrl = URL(string: (recipe["image"] as? String)!)
        let data = try? Data(contentsOf: imageUrl!)
        if let imageData = data {
            backdropImage.image = UIImage(data: imageData)
        }
//        ingredientsLabel.text = ingredientsArray.joined()
    
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
