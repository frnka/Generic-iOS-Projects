//
//  ThirdViewController.swift
//  MVCHacks
//
//  Created by Richard Frnka on 5/15/18.
//  Copyright © 2018 Richard Frnka. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func goToSecond(_ sender: Any) {
        print("clicking trigger button")
        controlNavigation()
    }
    func controlNavigation () {
        
        if let controllersOnNavStack = self.navigationController?.viewControllers, controllersOnNavStack.count >= 2 {
            print(controllersOnNavStack)
            
            let n = controllersOnNavStack.count
            if let tabBarVC = controllersOnNavStack[n-2] as? MyTabBarController {
                if let myTabs = tabBarVC.viewControllers{
                    print(myTabs)
                    let secondVC = myTabs[1] as! SecondViewController
                    secondVC.secondBool = true
                
                    self.navigationController?.pushViewController(secondVC, animated: true)
                }
                else{
                    self.navigationController?.pushViewController(tabBarVC, animated: true)
                }
            }
            else{
                print("no tab bar, let's see what happens by popping")
                self.navigationController?.popViewController(animated: true)
            }
            
        }
        else{
            print("no navigation stack?")
            print(self.navigationController)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    


}
