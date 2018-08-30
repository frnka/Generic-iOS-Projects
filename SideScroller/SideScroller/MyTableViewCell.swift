//
//  MyTableViewCell.swift
//  SideScroller
//
//  Created by Richard Frnka on 5/7/18.
//  Copyright © 2018 Richard Frnka. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collCell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow = 1
        let hardCodedPadding = 5
        let itemWidth = (collectionView.bounds.width / CGFloat(itemsPerRow)) - CGFloat(hardCodedPadding)
        let itemHeight = collectionView.bounds.height - CGFloat(2 * hardCodedPadding)
        return CGSize(width: itemWidth, height: itemHeight)
    }


    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
