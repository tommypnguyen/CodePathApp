//
//  EditViewController.swift
//  SugoiFridge
//
//  Created by Richard Hsu on 2020/3/15.
//  Copyright © 2020 TAR. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    
    // MARK: - Properties
    var ingredient : Ingredient?
    var index : Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        debugPrint(ingredient)
        debugPrint(index) 
    }
}
