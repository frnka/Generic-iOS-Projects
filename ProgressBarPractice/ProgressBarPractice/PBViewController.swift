//
//  ViewController.swift
//  ProgressBarPractice
//
//  Created by Richard Frnka on 4/24/18.
//  Copyright © 2018 Richard Frnka. All rights reserved.
//

import UIKit

class PBViewController: UIViewController {
    
   
    //declared variables. Duration configured to make timing work.
        var timer: Timer!
        var progressCounter:Float = 0.05
        let duration:Float = 20.0
        var progressIncrement:Float = 0.01
        let xpNeeded = 600
        let xp = 400
        var totalDistance: Float?
    
    
    @IBOutlet weak var circlePB: ProgressBarView!
    @IBOutlet weak var pv1: UIProgressView!
    
    @IBOutlet weak var pv2: UIProgressView!
    
    @IBOutlet weak var pv3: UIProgressView!
    
    @IBOutlet weak var pv4: UIProgressView!
    
    
    
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(false)
            
            //animations put in viewDidAppear because they were triggering too early in viewDidLoad
            pv1.animate(duration: 2.0, toPoint: 0.8)
            pv2.animate(duration: 2.0, toPoint: 0.7)
            pv3.animate(duration: 2.0, toPoint: 0.75)
            pv4.animate(duration: 2.0, toPoint: 0.6)
            totalDistance = Float(xp)/Float(xpNeeded)
            progressIncrement = totalDistance!/(duration )
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.showProgress), userInfo: nil, repeats: true)
        }
        override func viewDidLoad() {
            super.viewDidLoad()
            
            
            //Quick way to scale the size of the progress bars
            pv1.transform = pv1.transform.scaledBy(x: 1, y: 8)
            pv2.transform = pv2.transform.scaledBy(x: 1, y: 8)
            pv3.transform = pv3.transform.scaledBy(x: 1, y: 8)
            pv4.transform = pv4.transform.scaledBy(x: 1, y: 8)
        
        }
        @objc func showProgress() {
            //does the incrementing of the circle progress bar iteratively.
            
            if(progressCounter > totalDistance!){timer.invalidate()}
            circlePB.progress = progressCounter
            progressCounter = progressCounter + progressIncrement
            //circlePB.progressLayer.strokeEnd = CGFloat(progressCounter)
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            
        }
        
        
        
    }
        //sweet extension found at 
     //http://seanallen.co/posts/animated-progress-bar
    extension UIProgressView {
        
        func animate(duration: Double, toPoint: Float) {
            
            setProgress(0.01, animated: true)
            
            UIView.animate(withDuration: duration, delay: 0.0, options: .curveLinear, animations: {
                self.setProgress(toPoint, animated: true)
            }, completion: nil)
        }
}
