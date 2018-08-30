//
//  MyCollectionViewController.swift
//  MVCHacks
//
//  Created by Richard Frnka on 5/23/18.
//  Copyright © 2018 Richard Frnka. All rights reserved.
//

import UIKit

private let reuseIdentifier = "gridCell"
fileprivate let itemsPerRow: CGFloat = 3
class MyCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //collectionView?.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 4
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gridCell", for: indexPath) as! ProfileCollectionViewCell
        
        
        cell.nameLabel.text = "Name"
        cell.companyLabel.text = "Birthday"
        cell.positionLabel.text = "Occupation"
        
        // Configure the cell
    
        return cell
       
    }


}
extension MyCollectionViewController : UICollectionViewDelegateFlowLayout {
    //1
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = CGFloat(1.0)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    
    
    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
