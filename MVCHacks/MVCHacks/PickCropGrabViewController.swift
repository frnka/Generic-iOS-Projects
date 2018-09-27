//
//  PickCropGrabViewController.swift
//  MVCHacks
//
//  Created by Richard Frnka on 9/27/18.
//  Copyright © 2018 Richard Frnka. All rights reserved.
//
//
//Experiment to test the cropper for cropping images to squares and also see about grabbing screen images of views.
// WARNING: Must add the Privacy: Photo Gallery Addition Usage to the info.plist before running.

import UIKit

class PickCropGrabViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var imageChanged: Bool = false
    var imageView1: UIImageView!
    var imageView2: UIImageView!
    var imageView3: UIImageView!
    var imageView4: UIImageView!
     var imager: Int = 5
 
    var squareView: UIView!
    var snapButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildEverything(completion: {() in
            print("Everything should be built")
            self.view.setNeedsDisplay()
        })
        
    }
    
    func buildEverything(completion: ()->() ){
        squareView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        squareView.center = self.view.center
        
        imageView1 = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        imageView2 = UIImageView(frame: CGRect(x: 100, y: 0, width: 100, height: 100))
        imageView3 = UIImageView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        imageView4 = UIImageView(frame: CGRect(x: 0, y: 100, width: 100, height: 100))
        
        imageView1.tag = 0
        imageView2.tag = 1
        imageView3.tag = 2
        imageView4.tag = 3
        imageView1.image = UIImage(named: "SquareImage")
        imageView2.image = UIImage(named: "SquareImage")
        imageView3.image = UIImage(named: "SquareImage")
        imageView4.image = UIImage(named: "SquareImage")
        squareView.backgroundColor = .black
        squareView.insertSubview(imageView1, at: 1)
            squareView.insertSubview(imageView2, at: 1)
        squareView.addSubview(imageView1)
        squareView.addSubview(imageView2)
        squareView.addSubview(imageView3)
        squareView.addSubview(imageView4)
        
        self.view.addSubview(squareView)
        
        snapButton = UIButton(frame: CGRect(x: self.view.frame.width/2 - 50.0, y: self.view.frame.height-50.0, width: 100.0, height: 30.0))
        snapButton.setTitle("Snap Button", for: .normal)
        snapButton.titleLabel?.text = "Snap Button"
        snapButton.addTarget(self, action: #selector(snapAction), for: .touchUpInside)
        snapButton.layer.borderWidth = 1
        snapButton.layer.cornerRadius = 5
        snapButton.layer.borderColor = UIColor(white: 0.5, alpha: 1.0).cgColor
        self.view.addSubview(snapButton)
        imageView1.isUserInteractionEnabled = true
        imageView2.isUserInteractionEnabled = true
        imageView3.isUserInteractionEnabled = true
        imageView4.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        let gesture1 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        let gesture3 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView1.addGestureRecognizer(gesture)
        imageView2.addGestureRecognizer(gesture1)
        imageView3.addGestureRecognizer(gesture2)
        imageView4.addGestureRecognizer(gesture3)
        completion()
    }
    
    @objc func snapAction() {
        print("doing snap action")
        squareView.takeScreenshot()
    }
   
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        print("Image was tapped")
        
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
       
        imager = tappedImage.tag
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            print("imagePicker initiating")
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("Is this even being accessed?")
        //if let img = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage
        {
            switch imager{
            case 0:
                imageView1.contentMode = .scaleAspectFit
                imageView1.image = image
                self.imageChanged = true
                imageView1.setNeedsDisplay()
            case 1:
                imageView2.contentMode = .scaleAspectFit
                imageView2.image = image
                self.imageChanged = true
                imageView2.setNeedsDisplay()
            case 2:
                imageView3.contentMode = .scaleAspectFit
                imageView3.image = image
                self.imageChanged = true
                imageView3.setNeedsDisplay()
            case 3:
                imageView4.contentMode = .scaleAspectFit
                imageView4.image = image
                self.imageChanged = true
                imageView4.setNeedsDisplay()
            default:
                imageView1.contentMode = .scaleAspectFit
                imageView1.image = image
                self.imageChanged = true
                imageView1.setNeedsDisplay()
            }
            
        }
        dismiss(animated:true, completion: nil)
    }
    
}
extension UIView {
    
    func takeScreenshot() -> UIImage {
        
        // Begin context
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        
        // Draw view in that context
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        
        // And finally, get image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
       
        if let image = image {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            return image
        }
        else{
            return UIImage()
        }
    }
}
