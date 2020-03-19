//
//  APICallers.swift
//  SugoiFridge
//
//  Created by Richard Hsu on 2020/3/13.
//  Copyright © 2020 TAR. All rights reserved.
//

import Alamofire
import AlamofireImage
import Foundation
import SwiftyJSON

class SpoonCaller {
    static let client = SpoonCaller()
    
    
    // MARK: - InputViewController Helpers
    let downloader = ImageDownloader()
    
    func parseIngredientsRequest(inVC vc: InputViewController) {
        var url = SpoonacularAPI.baseURL.rawValue + SpoonacularAPI.parseIngredient.rawValue
        url += "?apiKey=\(SpoonacularAPI.richAPIKey.rawValue)"
        
        let headers: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
        let parameters: [String : Any] = ["ingredientList": vc.searchBar.text!, "servings": 1]
        
        AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate().responseJSON { response in
                switch response.result {
                    case .success(let value):
                        print("Spoonacular API request successful\n")
                        
                        let jsonData = JSON(value)
                        self.parseIngredient(inVC: vc, from: jsonData)
                    
                        vc.tableView.reloadData()
                        
                    case .failure(let error):
                        print("Spoonacular API request failed\n")
                        AlertControl.control.displayAlert(inVC: vc,withTitle: ErrorMessages.searchTitle.rawValue, andMsg: error.localizedDescription)
                }
        }
    }
    
    func parseIngredient(inVC vc: InputViewController, from data: JSON) {
        // data passed in is a list of length 1
        let data = data[0]
        
        let id     = data["id"].intValue
        let name   = data["name"].stringValue
        let unit   = data["unitShort"].stringValue
        let amount = data["amount"].doubleValue
        let aisle  = data["aisle"].stringValue
        let posUnits = data["possibleUnits"].arrayValue.map { $0.stringValue }
        let estCosts = data["estimatedCost"].dictionaryValue
        
        // Download ingredient image
        let imageString  = data["image"].stringValue
        let urlString = SpoonacularAPI.image.rawValue + ImageSize.small.rawValue + "/" + imageString
        let url = URL(string: urlString)!
        let urlRequest = URLRequest(url: url)

        downloader.download(urlRequest) { response in
            switch response.result {
                // If download image is successful, add the image to the
                // the ingredients list to be displayed
                case .success(let image):
                    print("Obtained \"\(name)\" image successfully\n")
                    // Add ingredient to list
                    let ingredient = Ingredient(id: id, name: name, image: image, imageName: imageString, unit: unit, amount: amount, aisle: aisle, cost: estCosts, possibleUnits: posUnits)
                    
                    vc.ingredientsList.append(ingredient)
                    vc.tableView.reloadData()
                
                // If download image failed, add an empty image to the
                // ingredients list
                case .failure(_):
                    print("Failed to obtain \"\(name)\" image\n")
                    let image = UIImage()
                
                    let ingredient = Ingredient(id: id, name: name, image: image, imageName: imageString, unit: unit, amount: amount, aisle: aisle, cost: estCosts, possibleUnits: posUnits)
                    
                    vc.ingredientsList.append(ingredient)
                    vc.tableView.reloadData()
            }
        }
    }
    
    
    // MARK: - EditViewController Helpers
    func getImage(of size: ImageSize, for ingredient: String) {
        let url = "\(SpoonacularAPI.image.rawValue)\(size.rawValue)" + "/" + ingredient
        
        
        AF.request(url).validate().responseJSON { response in
                switch response.result {
                    case .success(let value):
                        print("Obtained image from Spoonacular")
                        print(value)
                    case .failure(let error):
                        print("Obtaining image from Spoonacular failed with error: \(error)")
                }
        }
    }
}
