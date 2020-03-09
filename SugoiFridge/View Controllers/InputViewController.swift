//
//  InputViewController.swift
//  SugoiFridge
//
//  Created by Richard Hsu on 2020/3/8.
//  Copyright © 2020 TAR. All rights reserved.
//

import UIKit

class InputViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneButton: UIButton!
    
    
    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()

        // UI Customizations
        customizeDoneButton()
    }
    
    func setupTableView() {
        tableView.delegate   = self
        tableView.dataSource = self
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

        return cell
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
