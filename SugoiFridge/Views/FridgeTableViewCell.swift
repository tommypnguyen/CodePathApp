//
//  FridgeTableViewCell.swift
//  SugoiFridge
//
//  Created by Angelo Domingo on 3/22/20.
//  Copyright © 2020 TAR. All rights reserved.
//

import UIKit

class FridgeTableViewCell: UITableViewCell {

    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var compartmentLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
