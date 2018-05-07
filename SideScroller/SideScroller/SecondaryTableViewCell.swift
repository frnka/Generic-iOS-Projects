//
//  SecondaryTableViewCell.swift
//  SideScroller
//
//  Created by Richard Frnka on 5/7/18.
//  Copyright © 2018 Richard Frnka. All rights reserved.
//

import UIKit

class SecondaryTableViewCell: UITableViewCell {

    @IBOutlet weak var myTextView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
