//
//  My Sweet Vertical and Horizontal Scrolling TableViewController.swift
//  SideScroller
//
//  Created by Richard Frnka on 5/7/18.
//  Copyright © 2018 Richard Frnka. All rights reserved.
//

import UIKit

class MyTableViewController: UITableViewController  {

    let categories = ["cat1", "cat2", "cat3", "cat4", "cat5"]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
   
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y > 800) {
            print("moving down")
            let ip = IndexPath(row: 0, section: 1)
            self.tableView.scrollToRow(at: ip, at: .top, animated: true)
            // move up
        }
    }
   

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section{
        case 0:
            return 0
            
        case 1:
            return 1
            
        default:
            return 3
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        
        print(row)
        switch section{
        case 0:
              let cell = tableView.dequeueReusableCell(withIdentifier: "secondCell", for: indexPath) as! SecondaryTableViewCell
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyTableViewCell
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "secondCell", for: indexPath) as! SecondaryTableViewCell
            //cell.myTextView.text = "NEW INFORMATION WILL GO HERE AND BE EDITABLE."
            return cell
        }
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section{
        case 0:
            return 900
            
        case 1...(categories.count):
            return 650
            
        default:
            return 900
        }
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row > 0{
            let ip = IndexPath(row: 0, section: 1)
            self.tableView.scrollToRow(at: ip, at: .top, animated: true)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}
