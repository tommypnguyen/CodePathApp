//
//  FridgeViewController.swift
//  SugoiFridge
//
//  Created by Angelo Domingo on 3/7/20.
//  Copyright © 2020 TAR. All rights reserved.
//

import UIKit
import Alamofire
import Parse

class FridgeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let categories = ["Freezer","Fridge","Drawers"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FridgeFoodCategoryCell") as! FridgeTableViewCell
        
        cell.categoryLabel.text = categories[indexPath.row]
        
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logout(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        
        let delegate = self.view.window?.windowScene?.delegate as! SceneDelegate
            
        delegate.window?.rootViewController = loginViewController
    }
    override func viewDidAppear(_ animated: Bool) {
        
        /*
         override func viewDidAppear(_ animated: Bool) {
             super.viewDidAppear(animated)
             
             let query = PFQuery(className: "Posts")
             query.includeKeys(["author", "comments", "comments.author"])
             query.limit = 20
             
             query.findObjectsInBackground { (posts, error) in
                 if posts != nil {
                     self.posts = posts!
                     self.tableView.reloadData()
                 }
             }
         }
         */
    }
    
    //TableView
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FridgeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FridgeFoodCell", for: indexPath as IndexPath) as! FridgeCollectionViewCell

        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {

        return 2
    }

}
