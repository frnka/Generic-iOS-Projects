//
//  CardAnimationViewController.swift
//  MVCHacks
//
//  Created by Richard Frnka on 7/31/18.
//  Copyright © 2018 Richard Frnka. All rights reserved.
//

import UIKit

class CardAnimationViewController: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var cardImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeBigger()
        cardImage.isUserInteractionEnabled = true
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(self.wasDragged))
        cardImage.addGestureRecognizer(gesture)
        gesture.delegate = self
        // Do any additional setup after loading the view.
    }
    @objc func wasDragged(gesture: UIPanGestureRecognizer){
        print("Was dragged trigger")
            self.cardImage.layer.removeAllAnimations()
            let translation = gesture.translation(in: self.view)
            
            
            let currentState = cardImage.center.y
            let xState = cardImage.center.x
            
            // translation.y is the distance panned vertically in a single swipe detection.
            //cardImage.center.y is the center of the card View.
            // call self.view.frame.size.height to get height of the whole thing.
            
            //We can recenter at the middle on each swipe action.
            cardImage.center.y = translation.y + self.view.center.y
            // OR we can have it translate out of control
            //cardImage.center.y += translation.y
            
            //print("Because translation starts at 0 : \(translation.y), swiper view is jumping to \(cardImage.center.y) on the first drag.")
            // Customize this.
            
            
            //When the card goes out of sight...
            if cardImage.center.y < 40{
                //Putting this in so the card will disappear from view.
                cardImage.center.y = -300.0
        
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000), execute: {
                        self.cardImage.center = self.view.center
                        
                        
                    })
                }
                
                
            else{print("Weak drag")
                if gesture.state == .ended {
                    print("Gesture state was ended")
                    self.cardImage.center = self.view.center
                }
            }
    }
            
            
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func makeBigger(){
        let oldFrame = cardImage.frame
        let oldValue = cardImage.frame.width/2
        let newButtonWidth: CGFloat = 60
        
        /* Do Animations */
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            self.makeSmaller()
        })
        CATransaction.setAnimationDuration(0.5)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))
        
        // View animations
        
        UIView.animate(withDuration: 1.0) {
            self.cardImage.frame = CGRect(x: oldFrame.minX, y: oldFrame.minY, width: oldFrame.width*1.2, height: oldFrame.height*1.2)
            self.cardImage.center = self.view.center
        }
       
        CATransaction.commit()
    }
    func makeSmaller(){
        let oldFrame = cardImage.frame
        let oldValue = cardImage.frame.width/2
        let newButtonWidth: CGFloat = 60
        
        /* Do Animations */
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            self.makeBigger()
        })
        CATransaction.setAnimationDuration(0.5)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))
        
        // View animations
        
        UIView.animate(withDuration: 1.0) {
            self.cardImage.frame = CGRect(x: oldFrame.minX, y: oldFrame.minY, width: oldFrame.width*1.0/1.2, height: oldFrame.height*1.0/1.2)
            self.cardImage.center = self.view.center
        }
        
        CATransaction.commit()
    }

   

}
