//
//  RecipeCollectionViewController.swift
//  SugoiFridge
//
//  Created by Tommy Nguyen on 3/8/20.
//  Copyright © 2020 TAR. All rights reserved.
//

import UIKit
import Alamofire
import Parse


class RecipeCollectionViewController: UICollectionViewController {
    var numberOfRecipe: Int!
    var parameters = ["apiKey": "6b99189a3bf54d11aa2196d642496bac","number":"20"]
    var parameters2 = ["apiKey": "6b99189a3bf54d11aa2196d642496bac"]
    private let reuseIdentifier = "RecipeCell"
    var recipeArray = [[String: AnyObject]]()
    var ingredientsArray = [String]()
    var instructionsArray = [String]()
    var food = [PFObject]()


    func getFood() {
        let query = PFQuery(className: "Food")
        query.whereKey("userID", equalTo: PFUser.current())
        query.limit = 20
            
        query.findObjectsInBackground { (food, error) in
            if food != nil {
                self.food = food!
            } else {
                print(error?.localizedDescription as Any)
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        getFood()
        loadRecipes()
       }
    override func viewDidLoad() {
        if let layout = collectionView?.collectionViewLayout as? RecipeLayout {
          layout.delegate = self
        }
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
    }
    func loadRecipes() {
        var ingredientList = [String]()
        for item in self.food {
            ingredientList.append(item["foodName"] as! String)
        }
        parameters["ingredients"] = ingredientList.joined(separator: ",")
        AF.request("https://api.spoonacular.com/recipes/findByIngredients",method: .get, parameters:parameters).validate().responseJSON { (response) in
              guard let recipes = response.value else { return }
              if let tempArray = recipes as? [[String: AnyObject]] {
                  self.recipeArray.removeAll()
                  for recipe in tempArray {
                      self.recipeArray.append(recipe)
                  }
                  self.collectionView.reloadData()
              }
          }
      }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        let cell = sender as! RecipeCollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)!
        let recipe = recipeArray[indexPath.row]
        let detailsViewController = segue.destination as! RecipeDetailsViewController
        detailsViewController.recipe = recipe

    }
    

    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        return recipeArray.count

    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! RecipeCollectionViewCell
        cell.titleLabel.text = recipeArray[indexPath.row]["title"] as? String
        let imageUrl = URL(string: (recipeArray[indexPath.row]["image"] as? String)!)
        let data = try? Data(contentsOf: imageUrl!)
        if let imageData = data {
            cell.recipeImage.image = UIImage(data: imageData)
        }
        cell.layer.masksToBounds = true;
        cell.layer.cornerRadius = 15;
        return cell
    }
    

    // MARK: UICollectionViewDelegate
    

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}


extension RecipeCollectionViewController: RecipeLayoutDelegate {
  func collectionView(
      _ collectionView: UICollectionView,
      heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
    if recipeArray.count > 0 {
        let imageUrl = URL(string: (recipeArray[indexPath.row]["image"] as? String)!)
                let data = try? Data(contentsOf: imageUrl!)
        if let imageData = data {
            return (UIImage(data: imageData)?.size.height)!
        }
    }
   return 0
  }
}

