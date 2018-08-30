//
//  UserDefaultsViewController.swift
//  MVCHacks
//
//  Created by Richard Frnka on 7/26/18.
//  Copyright © 2018 Richard Frnka. All rights reserved.
//

import UIKit

class UserDefaultsTemplateViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func loadUserDefaults()-> (String?, Int?, String?, UIImage?){
        
        let defaults = UserDefaults.standard
        
        //Be careful pulling the types
        let name = defaults.string(forKey: "name")
        let intID = defaults.integer(forKey: "id")
        let email = defaults.string(forKey: "email")
        
        //Image loading setup
        var image: UIImage?
        var oldImageData: Data?
        let possibleOldImagePath = UserDefaults.standard.object(forKey: "path") as? String
        
        //Do the image load
        if possibleOldImagePath != nil{
            let oldFullPath = self.documentsPathForFileName(name: possibleOldImagePath!)
            do {
                oldImageData = try Data(contentsOf: oldFullPath)
            }
            catch {
                print ("loading image file error")
                print(oldFullPath)
            }
            
            // here is your saved image:
            image = UIImage(data: oldImageData! as Data)
            print("IMAGE SUCCESSFULLY LOADED!")
            
        }
        else{
            print("Image did not load")
        }
        
        //May want completion handler to make sure image loads before doing this.
        return (name, intID, email, image)
        
    }
    
    
    
    //Writes to the userDefaults. Be careful with the typing of the objects.
    private func setUserDefaults(name: String, idInt: Int, email: String?, image: UIImage?) {
        
        let defaults = UserDefaults.standard
        defaults.set(name, forKey: "name")
        defaults.set(idInt, forKey: "id")
        
        if let em = email {
            defaults.set(em, forKey: "email")
        }
        
        //This was the recommended way to store image to device for easy loading.
        if let image = image{
            let imageData = UIImageJPEGRepresentation(image, 1)
            let relativePath = "image_\(NSDate.timeIntervalSinceReferenceDate).jpg"
            let path = self.documentsPathForFileName(name: relativePath)
            do {
                try imageData?.write(to: path, options: .atomic)
            } catch
            {
                print("BIG ERROR IN DATA WRITE")
            }
            defaults.set(relativePath, forKey: "path")
            
            defaults.synchronize()
            
        }
        else{
            defaults.removeObject(forKey: "path")
            defaults.synchronize()
        }
        
    }
    //Helper function for caching profile Images
    func documentsPathForFileName(name: String) -> URL {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true);
        let path = paths[0] as String;
        let fullPath = URL(fileURLWithPath: path).appendingPathComponent(name)
        
        return fullPath
    }
    //Hard-remove the user defaults from the system
    private func removeUserDefaults(){
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
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
