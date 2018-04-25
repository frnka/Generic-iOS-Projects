//
//  ViewController.swift
//  BucketAnimationPractice
//
//  Created by Richard Frnka on 1/1/18.
//  Copyright © 2018 Richard Frnka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var uid: String?
    var images: [UIImage]!
    var images2: [UIImage]!
    var an2: UIImage?
    let n = 5
    var myImageViews = [UIImageView]()
    var drips = [UIView]()
    var myLabels = [UILabel]()
    var strings = ["Bucket1", "Bucket2", "Bucket3", "Bucket4", "Bucket5", "Bucket6"]
    var remainingLabel:UILabel?
    var path: UIBezierPath!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let w = self.view.frame.width
        let h = self.view.frame.height
        let wi:CGFloat = w/(CGFloat(n) + (CGFloat(n+1))/2)
        let si = wi/2
        let y1 = h/2
        let image0 = UIImage(named: "widebucket")!
        let image1 = UIImage(named: "widebucketfill1")!
        let image2 = UIImage(named: "widebucketfill2")!
        let image3 = UIImage(named: "widebucketfill3")!
        let image4 = UIImage(named: "widebucketfill4")!
        let image5 = UIImage(named: "widebucketfill5")!
        let image6 = UIImage(named: "widebucketfill6")!
        let image01 = UIImage(named: "widebucketcurve01")!
        let image02 = UIImage(named: "widebucketcurve02")!
        let image03 = UIImage(named: "widebucketcurve03")!
        let image04 = UIImage(named: "widebucketcurve04")!
        let image05 = UIImage(named: "widebucketcurve05")!
        let image06 = UIImage(named: "widebucketcurve06")!
        let image07 = UIImage(named: "widebucketcurve07")!
        let image08 = UIImage(named: "widebucketcurve08")!
        
        images = [image0, image1, image2, image3, image4, image5, image6]
        images2 = [image0, image1, image01, image02, image03, image04, image05, image06, image07, image08, image6]
        let animatedImage = UIImage.animatedImage(with: images, duration: 1.0)
        
        an2 = UIImage.animatedImage(with: images2, duration: 2.0)
        
        makeBuckets()
        let button = UIButton(frame: CGRect(x: w/2, y: 100, width: 150, height: 50))
        button.backgroundColor = .gray
        button.setTitle("Start Fill", for: .normal)
        button.addTarget(self, action: #selector(startFill), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    @objc func startFill(){
        let w = self.view.frame.width
        let h = self.view.frame.height
        let wi:CGFloat = w/(CGFloat(n) + (CGFloat(n+1))/2)
        let si = wi/2
        let y1 = h/2
        let bigBucket = UIImage(named: "graybucket")!
        let thisImage = UIImageView(image: bigBucket)
        thisImage.frame = CGRect(x: 2*wi, y: 150, width: 3*wi/2, height: 3*wi/2)
        UIView.animate(withDuration: 2.0, delay: 1.0, options: [],
                       animations: {
                        thisImage.center.x -= (2*wi - si)
                        thisImage.center.y -= (150 - y1)
                        
                        
                        
        },
                       completion: {finished in self.rotateBucket()}
        )
        
    }
    func rotateBucket(){
        let w = self.view.frame.width
        let h = self.view.frame.height
        let wi:CGFloat = w/(CGFloat(n) + (CGFloat(n+1))/2)
        let si = wi/2
        let y1 = h/2
        let bigBucket = UIImage(named: "graybucket")!
        let thisImage = UIImageView(image: bigBucket)
        thisImage.frame = CGRect(x: si, y: y1-150, width: 3*wi/2, height: 3*wi/2)
        self.view.addSubview(thisImage)
        UIView.animate(withDuration: 2.0, delay: 1.0, options: [],
                       animations: {
                        thisImage.transform = thisImage.transform.rotated(by: 5 * .pi/4)
        },
                       completion: nil
        )
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            thisImage.isHidden = true
            self.bucketFillAnimation()
        }
    }
    func bucketFillAnimation(){
        
        let w = self.view.frame.width
        let h = self.view.frame.height
        let wi:CGFloat = w/(CGFloat(n) + (CGFloat(n+1))/2)
        let si = wi/2
        let y1 = h/2
        let bigBucket = UIImage(named: "graybucket")!
        let thisImage = UIImageView(image: bigBucket)
        thisImage.frame = CGRect(x: si, y: y1-150, width: 3*wi/2, height: 3*wi/2)
        thisImage.transform = thisImage.transform.rotated(by: 5 * .pi/4)
        let dripView = UIView()
        dripView.frame = CGRect(x: 3*si-10,y: y1-65, width: 5, height: 100)
        dripView.backgroundColor = .black
        self.view.addSubview(dripView)
        self.view.addSubview(thisImage)
        for i in 0...n-1{
            if i < n-1{
                UIView.animate(withDuration: 1.0, delay: 2.0+1.95*Double(i), options: [],
                               animations: {
                                thisImage.center.x += wi+si
                                dripView.center.x += wi+si
                  },
                               completion: nil
                )
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2*Double(i)) {
                
                self.myImageViews[i].startAnimating()
                self.myImageViews[i].image = UIImage(named: "widebucketfill6")!
                
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2*Double(self.n)) {
                dripView.isHidden = true
                thisImage.isHidden = true
                self.rotateBack()
            }
        }
        
    }
    func rotateBack(){
        let w = self.view.frame.width
        let h = self.view.frame.height
        let wi:CGFloat = w/(CGFloat(n) + (CGFloat(n+1))/2)
        let si = wi/2
        let y1 = h/2
        let bigBucket = UIImage(named: "graybucket")!
        let thisImage = UIImageView(image: bigBucket)
        thisImage.frame = CGRect(x: si + (wi+si) * (CGFloat(n)-1), y: y1-150, width: 3*wi/2, height: 3*wi/2)
        thisImage.transform = thisImage.transform.rotated(by: 5 * .pi/4)
        self.view.addSubview(thisImage)
        UIView.animate(withDuration: 1.5, delay: 1.0, options: [],
                       animations: {
                        thisImage.transform = thisImage.transform.rotated(by: 3 * .pi/4)
         },
                       completion: nil
        )
    }
   
    func makeBuckets(){
        let w = self.view.frame.width
        let h = self.view.frame.height
        let imageName = "widebucket"
        let image = UIImage(named: imageName)
        let ky = self.navigationController?.navigationBar.frame.size.height
        
        let wi:CGFloat = w/(CGFloat(n) + (CGFloat(n+1))/2)
        let si = wi/2
        let y1 = h/2
        for i in 0...n
        {
            let imageView = UIImageView(image: image!)
            imageView.frame = CGRect(x: CGFloat(i)*(wi + si)+si, y: y1, width: wi, height: wi)
            
            imageView.animationImages = images2
            imageView.animationDuration = 2.0
            imageView.animationRepeatCount = 1
            self.view.addSubview(imageView)
            
            myImageViews += [imageView]
            let label = UILabel()
            label.frame = CGRect(x: CGFloat(i)*(wi + si)+si - 10, y: y1+wi+5, width: wi + 20, height: wi/2)
            print(strings[i])
            label.text = strings[i]
            label.font = UIFont.systemFont(ofSize: 11.0)
            label.textAlignment = .center
            myLabels += [label]
            self.view.addSubview(label)
            }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

