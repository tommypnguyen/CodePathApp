//
//  InputViewController.swift
//  SugoiFridge
//
//  Created by Richard Hsu on 2020/3/8.
//  Copyright © 2020 TAR. All rights reserved.
//

import Alamofire
import UIKit

class InputViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
//
//        cell.textLabel!.text = "Tomatoes"
//
//        return cell
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.inputTableView.rawValue) as! IngredientTableViewCell

        cell.ingredientNameLabel.text = "Tomatoes"
        cell.amountLabel.text = "1"
        cell.unitLabel.text   = "lb"
        cell.drawerLabel.text = "Vegetables"

        return cell
    }
    
    
    // MARK: - Search Bar Functions
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searching...")
        
        
    }
}
