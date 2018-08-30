//
//  SecondViewController.swift
//  MVCHacks
//
//  Created by Richard Frnka on 5/15/18.
//  Copyright © 2018 Richard Frnka. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    var secondBool: Bool?
    
    
    @IBOutlet weak var myLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if secondBool ?? false {
            myLabel.text = "2nd. Launched by three"
            
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
