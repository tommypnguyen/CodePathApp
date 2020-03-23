//
//  FridgeViewController.swift
//  SugoiFridgen
//
//  Created by Angelo Domingo on 3/7/20.
//  Copyright © 2020 TAR. All rights reserved.
//

import UIKit
import Alamofire
import Parse

class FridgeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellSpacingHeight: CGFloat = 10
    
    @IBOutlet weak var tableView: UITableView!
    var indexToEdit: Int = 0
    var selectedFood: PFObject!
    var food = [PFObject]()
    
    let myRefreshControl = UIRefreshControl()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return food.count
    }

    // There is just one row in every section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 143;//Choose your custom row height
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FridgeTableViewCell") as! FridgeTableViewCell
        
        let foodObj = food[indexPath.section]
        
        cell.foodLabel.text = foodObj["foodName"] as? String ?? ""
        cell.compartmentLabel.text = foodObj["compartment"] as? String ?? ""
        cell.typeLabel.text = foodObj["aisle"] as? String ?? ""
        cell.amountLabel.text = "\(foodObj["quantity"]!)"
        cell.unitLabel.text = foodObj["unit"] as? String ?? ""
        
        var image = UIImage()
        
        if foodObj["image"] != nil {
            let foodImage = foodObj["image"] as! PFFileObject
            foodImage.getDataInBackground { (imageData: Data?, error: Error?) in
                if let error = error {
                    print(error.localizedDescription)
                } else if let imageData = imageData {
                    image = UIImage(data:imageData)!
                    cell.foodImage.image = image
                }
            }
        }
        
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 15
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Get the ingredient that needs to be passed to next scene
        // and save it locally to be accessed later
        selectedFood     = food[indexPath.section]
        indexToEdit      = indexPath.row
        
        performSegue(withIdentifier: "editFoodSegue", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "editFoodSegue") {
            let destinationVC = segue.destination as! EditFoodViewController
            
           //destinationVC.delegate   = self
            destinationVC.ingredient = selectedFood
            destinationVC.index      = indexToEdit
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        
        getFood()
        
        myRefreshControl.addTarget(self, action: #selector(getFood), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
    }
    
    @IBAction func logout(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        
        let delegate = self.view.window?.windowScene?.delegate as! SceneDelegate
            
        delegate.window?.rootViewController = loginViewController
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        getFood()
        
        self.tableView.reloadData()
    }
    
    @objc func getFood() {
        let query = PFQuery(className: "Food")
        query.whereKey("userID", equalTo: PFUser.current())
        query.limit = 20
            
        query.findObjectsInBackground { (food, error) in
            if food != nil {
                self.food = food!
                self.tableView.reloadData()
                       
                self.tableView.reloadData()
                self.myRefreshControl.endRefreshing()
                
            } else {
                print(error?.localizedDescription as Any)
            }
        }
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
