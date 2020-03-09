//
//  IngredientTableViewCell.swift
//  SugoiFridge
//
//  Created by Richard Hsu on 2020/3/8.
//  Copyright © 2020 TAR. All rights reserved.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    @IBOutlet weak var ingredientImage: UIImageView!
    @IBOutlet weak var ingredientNameLabel: UILabel!
    
    
    // MARK: - Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
