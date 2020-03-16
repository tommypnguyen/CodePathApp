//
//  EditViewController.swift
//  SugoiFridge
//
//  Created by Richard Hsu on 2020/3/15.
//  Copyright © 2020 TAR. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    
    // MARK: - Properties
    
    
    @IBOutlet weak var ingredientImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var quantityField: UITextField!
    @IBOutlet weak var unitField: UITextField!
    @IBOutlet weak var compartmentField: UITextField!
    @IBOutlet weak var drawerField: UITextField!
    
    var ingredient : Ingredient?
    var index : Int?

    
    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateUI()
    }
    
    func populateUI() {
        nameLabel.text        = ingredient?.name
        quantityField.text    = String(format: "%.1f", ingredient!.amount)
        unitField.text        = ingredient?.unit
        compartmentField.text = ingredient?.compartment
        drawerField.text      = ingredient?.aisle
        
        // Download large image from Spoonacular
        let urlString = SpoonacularAPI.image.rawValue + ImageSize.large.rawValue + "/" + ingredient!.imageName
        let url = URL(string: urlString)!
        
        // Assign image to UIImageView
        ingredientImage.af.setImage(withURL: url)
    }
}
