//
//  MyTableViewController.swift
//  SideScroller
//
//  Created by Richard Frnka on 5/7/18.
//  Copyright © 2018 Richard Frnka. All rights reserved.
//

import UIKit

class MyTableViewController: UITableViewController {

    let categories = ["cat1", "cat2", "cat3", "cat4", "cat5"]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return categories.count + 3
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0:
            return "Profile Section"
        
        case 1...(categories.count):
            return categories[section-1]
        
        default:
            return "Big Text View"
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section{
        case 0:
            return 1
            
        case 1...(categories.count):
            return 1
            
        default:
            return 2
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        print(row)
        switch section{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "picCell", for: indexPath) as! PictureTableViewCell
            return cell
            
        case 1...(categories.count):
            let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyTableViewCell
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "secondCell", for: indexPath) as! SecondaryTableViewCell
            cell.myTextView.text = "NEW INFORMATION WILL GO HERE AND BE EDITABLE."
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section{
        case 0:
            return 90
            
        case 1...(categories.count):
            return 120
            
        default:
            return 120
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}
