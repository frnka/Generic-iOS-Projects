//
//  ImageStorageViewController.swift
//  MVCHacks
//
//
//  Created by Richard Frnka on 2/2/18.
//  Copyright © 2018 Richard Frnka. All rights reserved.
//


//Made for storing images through userDefaults without using coreData. Having small jpgs here is super important, and you probably shouldn't be storing to UD with anything larger than 0.5 MB.

import UIKit

class LocalImageStorageViewController: UIViewController {
    @IBOutlet weak var quickImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //putImageInUserDefaults(name:String, image: UIImage?)
        //loadImageFromUserDefaults()
    }
    private func putImageInUserDefaults(name: String, image: UIImage?, imageURL: String?) {
        
        let defaults = UserDefaults.standard
        defaults.set(name, forKey: "name")
        if imageURL != nil {
            defaults.set(imageURL!, forKey: "imageURL")
        }
        if image != nil {
            let imageData = UIImageJPEGRepresentation(image!, 1)
            let relativePath = "image_\(NSDate.timeIntervalSinceReferenceDate).jpg"
            let path = self.documentsPathForFileName(name: relativePath)
            do {
                try imageData?.write(to: path, options: .atomic)
            } catch
            {
                print("ERROR IN DATA WRITE")
            }
            defaults.set(relativePath, forKey: "path")
            
            defaults.synchronize()}
        else{defaults.synchronize()}
        
        
    }
    func loadImageFromUserDefaults()
    {
        //print(UserDefaults.standard.object(forKey: "name"))
        //print(UserDefaults.standard.object(forKey: "uid"))
        //print(UserDefaults.standard.object(forKey: "path"))
        
        let possibleOldImagePath = UserDefaults.standard.object(forKey: "path") as? String
        var oldImageData: Data?
        if possibleOldImagePath != nil{
            let oldFullPath = self.documentsPathForFileName(name: possibleOldImagePath!)
            do {
                oldImageData = try Data(contentsOf: oldFullPath)
            }
            catch {
                print ("loading image file error")
            }
            // here is your saved image:
            quickImage.image = UIImage(data: oldImageData! as Data)
        }
        else{
            print("Loading from User Defaults didn't work out.")
        }
        
    }
    
    
    func documentsPathForFileName(name: String) -> URL {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true);
        let path = paths[0] as String;
        let fullPath = URL(fileURLWithPath: path).appendingPathComponent(name)
        
        return fullPath
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
