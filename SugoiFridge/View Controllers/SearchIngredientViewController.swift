//
//  SearchIngredientViewController.swift
//  SugoiFridge
//
//  Created by Richard Hsu on 2020/3/13.
//  Copyright © 2020 TAR. All rights reserved.
//

import UIKit

class SearchIngredientViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupSearchBar()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate   = self
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
    }
    

    // MARK: - TableView Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.newIngTableView.rawValue) as! NewIngredientTableViewCell
        
        cell.nameLabel.text = "Chicken"
        
        return cell
    }
    
    
    // MARK: - Search Bar Functions
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searching...")
        
        // Request to Spoonacular for ingredient info
        
        /*
        let url = String(format: SpoonacularAPI.ingredientInfo.rawValue, <#T##arguments: CVarArg...##CVarArg#>)
        AF.request(SpoonacularAPI.ingredientInfo, method: <#T##HTTPMethod#>, parameters: <#T##Parameters?#>, encoding: <#T##ParameterEncoding#>, headers: <#T##HTTPHeaders?#>, interceptor: <#T##RequestInterceptor?#>)
        */
        
        // Store ingredient onto Parse
        
        // Display ingredient on screen
    }
}
