//
//  FullTableViewCell.swift
//  SideScroller
//
//  Created by Richard Frnka on 8/1/18.
//  Copyright © 2018 Richard Frnka. All rights reserved.
//

import UIKit

class FullTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardView", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow = 6
        let hardCodedPadding = 0
        //let itemWidth = (collectionView.bounds.width / CGFloat(itemsPerRow)) - CGFloat(hardCodedPadding)
        //let itemHeight = collectionView.bounds.height - CGFloat(2 * hardCodedPadding)
        
        let itemWidth = collectionView.bounds.width
        let itemHeight = collectionView.bounds.height
        return CGSize(width: itemWidth, height: itemHeight)
    }


    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
