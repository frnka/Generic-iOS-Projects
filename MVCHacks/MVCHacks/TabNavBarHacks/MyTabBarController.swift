//
//  MyTabBarViewController.swift
//  MVCHacks
//
//  Created by Richard Frnka on 5/15/18.
//  Copyright © 2018 Richard Frnka. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let logo = UIImage(named: "bestLogo")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"user_male"), style: .plain, target: self, action: #selector(userTapped))
        self.navigationItem.rightBarButtonItem?.tintColor = .darkGray
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"home"), style: .plain, target: self, action: #selector(homeTapped))
        self.navigationItem.leftBarButtonItem?.tintColor = .darkGray
        
    }
    @objc func userTapped(){print("User Clicked")}
    @objc func homeTapped(){print("Home Clicked")}

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
