//
//  VerticalScrollAnimationViewController.swift
//  MVCHacks
//
//  Created by Richard Frnka on 9/5/18.
//  Copyright © 2018 Richard Frnka. All rights reserved.
//

import UIKit

class VerticalScrollAnimationViewController: UIViewController {
    var myImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myImageView = UIImageView(frame: CGRect(x: 0, y: -self.view.frame.height*2, width: self.view.frame.width, height: self.view.frame.height*3))
        myImageView.image = UIImage(named: "SixRoll")
        self.view.addSubview(myImageView)
        runAnimation()
    }
    func runAnimation(){
        UIView.animate(withDuration: 3.0, delay: 0, options: [.repeat, .curveLinear], animations: {
            let translate = CGAffineTransform(translationX: 0, y: self.view.frame.height*2)
            self.myImageView.transform = translate
        }, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

    

}
