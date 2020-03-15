//
//  FridgeTableViewCell.swift
//  SugoiFridge
//
//  Created by Angelo Domingo on 3/8/20.
//  Copyright © 2020 TAR. All rights reserved.
//

import UIKit

class FridgeTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var foodCollection: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        foodCollection.delegate = self
        foodCollection.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension FridgeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = foodCollection.dequeueReusableCell(withReuseIdentifier: "FridgeFoodCell", for: indexPath)
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 179, height: 117)
    }
    
}
