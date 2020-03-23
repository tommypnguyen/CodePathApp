//
//  InputViewController.swift
//  SugoiFridge
//
//  Created by Richard Hsu on 2020/3/8.
//  Copyright © 2020 TAR. All rights reserved.
//

import UIKit

class InputViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, IngredientsDelegate {

    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var ingredientsList: [Ingredient] = []
    var ingredientToEdit : Ingredient?
    var indexToEdit : Int?
    
    
    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting up delegates
        setupTableView()
        setupSearchBar()
        setupGestureRecognizer()

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
    
    func setupGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
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

        cell.ingredientNameLabel.text = ingredient.name.capitalizeFirstLetter()
        cell.amountLabel.text = String(format: "%.1f", ingredient.amount)
        cell.unitLabel.text   = ingredient.unit
        cell.drawerLabel.text = ingredient.aisle
        cell.compartmentLabel.text = ingredient.compartment
        cell.ingredientImage.image = ingredient.image

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Get the ingredient that needs to be passed to next scene
        // and save it locally to be accessed later
        ingredientToEdit = ingredientsList[indexPath.row]
        indexToEdit      = indexPath.row
        
        performSegue(withIdentifier: SegueIdentifiers.editSegue.rawValue, sender: self)
    }
    
    
    // MARK: - Ingredients Delegate
    func updateIngredient(with newIngredient: Ingredient, at index: Int) {
        ingredientsList[index] = newIngredient
        tableView.reloadData()
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == SegueIdentifiers.editSegue.rawValue) {
            let destinationVC = segue.destination as! EditViewController
            
            destinationVC.delegate   = self
            destinationVC.ingredient = ingredientToEdit
            destinationVC.index      = indexToEdit
        }
    }
    
    
    // MARK: - Search Bar Functions
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Check if search bar is empty
        if searchBar.text == "" {
            AlertControl.control.displayAlert(inVC: self, withTitle: ErrorMessages.searchTitle.rawValue, andMsg: ErrorMessages.emptySearchMsg.rawValue)
        }
        else {
            SpoonCaller.client.parseIngredientsRequest(inVC: self)
            searchBar.text = ""
        }
    }
    
    
    // MARK: - Actions
    @IBAction func onDone(_ sender: Any) {
        // loop through each ingredient in ingredientsList, and
        // save each one to the database
        for ingredient in ingredientsList {
            ParseCaller.client.toUpdateIngredient(inVC: self, with: ingredient)
//            saveIngredient(ingredient)
        }
        
        performSegue(withIdentifier: SegueIdentifiers.fridgeSegue.rawValue, sender: nil)
    }
}
