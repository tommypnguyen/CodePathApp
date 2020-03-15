//
//  APICallers.swift
//  SugoiFridge
//
//  Created by Richard Hsu on 2020/3/13.
//  Copyright © 2020 TAR. All rights reserved.
//

import Alamofire
import Foundation

class APICaller {
    static let client = APICaller()
    
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
