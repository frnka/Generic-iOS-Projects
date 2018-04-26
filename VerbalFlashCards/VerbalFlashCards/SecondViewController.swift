//
//  SecondViewController.swift
//  VerbalFlashCards
//
//  Created by Richard Frnka on 4/26/18.
//  Copyright © 2018 Richard Frnka. All rights reserved.
//

//practice with the flipping animation
import UIKit

class SecondViewController: UIViewController {
    var myBool:Bool = false
    @IBOutlet weak var myImage: UIImageView!
    
    @IBAction func clicked(_ sender: Any) {
        if !myBool{
        let image = UIImage(named: "bell")
        myImage.image = image
        UIView.transition(with: myImage, duration: 2, options: .transitionFlipFromRight, animations: nil, completion: nil)
            
        }
        else{
            let image = UIImage(named: "box")
            myImage.image = image
            UIView.transition(with: myImage, duration: 2, options: .transitionFlipFromRight, animations: nil, completion: nil)
            
        }
        myBool = !myBool
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}
