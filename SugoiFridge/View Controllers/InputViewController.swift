//
//  InputViewController.swift
//  SugoiFridge
//
//  Created by Richard Hsu on 2020/3/8.
//  Copyright © 2020 TAR. All rights reserved.
//

import Alamofire
import AlamofireImage
import SwiftyJSON
import UIKit

class InputViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var ingredientsList: [Ingredient] = []
    
    
    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting up delegates
        setupTableView()
        setupSearchBar()

        // UI Customizations
        customizeDoneButton()
    }
    
    func setupTableView() {
        tableView.delegate   = self
        tableView.dataSource = self
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
    }
    
    func customizeDoneButton() {
        doneButton.layer.cornerRadius = CGFloat(CustomUI.cornerRadius.rawValue)
    }
    
    
    // MARK: - Table View DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.inputTableView.rawValue) as! IngredientTableViewCell
        
        let ingredient = ingredientsList[indexPath.row]

        cell.ingredientNameLabel.text = ingredient.name
        cell.amountLabel.text = String(format: "%.1f", ingredient.amount)
        cell.unitLabel.text   = ingredient.unit
        cell.drawerLabel.text = ingredient.aisle
        
        let urlString = SpoonacularAPI.image.rawValue + ImageSize.small.rawValue + "/" + ingredient.image
        let url = URL(string: urlString)!
        cell.ingredientImage.af.setImage(withURL: url)

        return cell
    }
    
    
    // MARK: - Search Bar Functions
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Check if search bar is empty
        if searchBar.text == "" {
            print("Search cannot be empty")
            
            // TODO: display dialogue box
        }
        else {
            parseIngredientsRequest()
        }
    }
    
    
    // MARK: - Network Requests
    func parseIngredientsRequest() {
        var url = SpoonacularAPI.baseURL.rawValue + SpoonacularAPI.parseIngredient.rawValue
        url += "?apiKey=\(SpoonacularAPI.richAPIKey.rawValue)"
        
        let headers: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
        let parameters: [String : Any] = ["ingredientList": searchBar.text!, "servings": 1]
        
        AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate().responseJSON { response in
                switch response.result {
                    case .success(let value):
                        print("Spoonacular API request success")
                        
                        let jsonData = JSON(value)
                        self.parseIngredient(from: jsonData)
                    
                        self.tableView.reloadData()
                        
                    case .failure(let error):
                        print("Spoonacular API request failed with error: \(error)")
                }
        }
    }
    
    
    // MARK: - Data Parsing
    func parseIngredient(from data: JSON) {
        let data = data[0]
        
        let id     = data["id"].intValue
        let name   = data["name"].stringValue
        let image  = data["image"].stringValue
        let unit   = data["unitShort"].stringValue
        let amount = data["amount"].doubleValue
        let aisle  = data["aisle"].stringValue
        let posUnits = data["possibleUnits"].arrayValue.map { $0.stringValue }
        let estCosts = data["estimatedCost"].dictionaryValue
        
        let ingredient = Ingredient(id: id, name: name, image: image, unit: unit, amount: amount, aisle: aisle, possibleUnits: posUnits, cost: estCosts)
        
        ingredientsList.append(ingredient)
    }
}
