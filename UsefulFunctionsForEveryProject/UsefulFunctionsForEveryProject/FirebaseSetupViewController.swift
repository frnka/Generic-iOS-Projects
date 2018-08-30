//
//  FirebaseSetupViewController.swift
//  MVCHacks
//
//  Created by Richard Frnka on 8/20/18.
//  Copyright © 2018 Richard Frnka. All rights reserved.


// Setting up with Firebase is the easy part and their documentation is pretty solid. These are helper methods and such to do a few more advanced things like:
// -Full Image Loading and Object Population in One Function
// -Spinner Shown Until Done
// -Cache Images with SD Firebase UI function
// -Authentication Handling with Forceful Removal if Not
// -UserDefaults Interfacing with Auth
//

// BUILD FAILED: As it stands, this page will not build standing alone.These are segmented functions that require some set up to use. I suggest going line by line and commenting things in and out as you go along

//  There are going to be errors until you import Firebase and Firebase Storage Cocoapods, add an Object to populate from Firestore, and set up Auth and the Firestore components online. And Toaster to make some nice alert toasts

import UIKit
import Firebase
import FirebaseUI
import Toaster

class FirebaseSetupViewController: UIViewController {
    
    var sv = UIView()
    let db = Firesbase.firestore();
    
    //View did load checks authentication and if not, chucks you out. If so, fires the listener, etc...
    override func viewDidLoad() {
        super.viewDidLoad()
        handleAuth(completion: {(uid) in
            print("authentication handled, let's grab some data")
            //loadUserDefaults(uid: uid)
            
            myDatabaseListener(completion: { () in
                self.removeSpinner(spinner: self.sv)
                if self.myArray.count != 0{
                    //self.tableView.reloadData()
                    print("We've loaded something")
                    let toast = Toast(text: "There are \(self.myArray.count) objects", duration: Delay.short)
                    toast.show()
                }
                else{
                    let toast = Toast(text: "There are no objects", duration: Delay.short)
                    toast.show()
                }
            })
        })
        
        
    }
    
    
    //MARK: Authentication
    private func handleAuth(completion: @escaping (String)->()){
        if let user = Auth.auth().currentUser {
            //turns on spinner
            sv = self.displaySpinner(onView: self.view)
            completion(user.uid)
        }
        else {
            removeUserDefaults()
            forceSignOut()
            print("no user signed in ")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "SignIn") as! SignInViewController
            self.present(vc, animated: false, completion: nil)
            
        }
    }
    
    
    
    func writeObjectWithImagesToDB(completion: (Object?) -> ()){
        
        var myObject: Object?
        let dispatch = DispatchGroup()
        
        if !nothingChanged {
            dispatch.enter()
            let newRef = self.db.collection("cards").document(cardID!)
            var faceURL: String?
            var logoURL: String?
            dispatch.leave()
            
            if logoChanged{
                dispatch.enter()
                if let image = logoImage.image {
                    let photoData = UIImageJPEGRepresentation(image, 0.15)
                    logoURL = self.sendLogo(photoData: photoData!)
                    newRef.updateData(["logo": logoURL])
                }
                dispatch.leave()
            }
            
            
            
            if faceChanged{
                dispatch.enter()
                if let image = faceImage.image {
                    let photoData = UIImageJPEGRepresentation(image, 0.15)
                    faceURL = self.sendFace(photoData: photoData!)
                    newRef.updateData(["face": faceURL])
                }
                dispatch.leave()
                
            }
            
            dispatch.enter()
            let logo = logoURL ?? "gs://tag-u-8abe1.appspot.com/default/logo2.png"
            
            let face = faceURL ?? ""
            myCard = FullCard(userID: self.uid!, user_name: newName, face: faceImage.image, faceURL: face, cardID: cardID!, company: company1, logo: logoImage.image, logoURL: logo, position: position1, phone: phone1, email: email1, twitter: twitter, facebook: facebook, instagram: insta, linked: linked, address:address1, website: website1)
            newRef.updateData([
                "name": newName,
                "company": company1,
                "position": position1,
                "phone": phone1,
                "email": email1,
                "facebook": facebook ?? "",
                "instagram": insta ?? "",
                "linkedIn": linked ?? "",
                "twitter": twitter ?? "",
                "address": address1,
                "website": website1
                ])
            dispatch.leave()
            
        }
        else{print("nothing changed")
            
        }
        dispatch.notify(queue: .main){
            print("Should've loaded the images right")
            
            
        }
        
        
        let dispatch2 = DispatchGroup()
        
        var imageURL: String?
        
        if let image = myImageView.image {
            dispatch2.enter()
            
            //Compresses the image down to 15%. Maybe lessen this up a little.
            let photoData = UIImageJPEGRepresentation(image, 0.15)
            imageURL = self.sendLogo(photoData: photoData!)
            dispatch2.leave()
        }
        var faceURL: String?
        if let image = faceImage.image {
            dispatch2.enter()
            if defaultImage == nil {
                self.setDefaultImage(completion: {() -> () in
                    let photoData = UIImageJPEGRepresentation(image, 0.15)
                    faceURL = self.sendFace(photoData: photoData!)
                })
            }
            else{
                let photoData = UIImageJPEGRepresentation(image, 0.15)
                faceURL = self.sendFace(photoData: photoData!)
            }
            
            dispatch2.leave()
        }
        dispatch2.enter()
        let logo = logoURL ?? "gs://tag-u-8abe1.appspot.com/default/logo2.png"
        let face = faceURL ?? ""
        
        let newRef = self.db.collection("cards").document()
        let myID = newRef.documentID
        print("cardID: \(myID)")
        myCard = FullCard(userID: self.uid!, user_name: newName, face: faceImage.image, faceURL: face, cardID: myID, company: company1, logo: logoImage.image, logoURL: logo, position: position1, phone: phone1, email: email1, twitter: twitter, facebook: facebook, instagram: insta, linked: linked, address: address1, website: website1)
        newRef.setData(["name": newName,
                        "userID": self.uid!,
                        "company": company1,
                        "position": position1,
                        "phone": phone1,
                        "email": email1,
                        "logo": logo,
                        "cardID": myID,
                        "face": face,
                        "address": address1,
                        "website": website1
            ])
        dispatch2.leave()
        dispatch2.notify(queue: .main){
            print("On an add, the images should now be loaded.")
            
            
        }
        
        
        
        
        //let card2 = CardInfo(userID: self.uid!, user_name: newName, face_pic: face, card_title: "", cardID: myID, card_bio: "", company_name: company1, company_logo: logo, company_position: position1, phone: phone1, address: "", email: email1, website: "")
        
        //myCard = FullCard(userID: self.uid!, user_name: newName, face: faceImage.image, faceURL: face, cardID: myID, company: company1, logo: logoImage.image, logoURL: logo, position: position1, phone: phone1, email: email1, twitter: twitter, facebook: facebook, instagram: insta, linked: linked)
        
        print("Database Write Complete")
        completion(myCard)
        
    }
    //MARK: Write Image to UserDefaults
    //Writes image to user defaults, retrievable with the loadImageFromUserDefaults Function
    private func writeImageToUserDefaults(photoData: Data)
    {
        let relativePath = "image_\(NSDate.timeIntervalSinceReferenceDate).jpg"
        let path = self.documentsPathForFileName(name: relativePath)
        do {
            try photoData.write(to: path, options: .atomic)
        } catch
        {
            print("Error writing image to userDefaults")
        }
        defaults.set(relativePath, forKey: "path")
        defaults.synchronize()
    }
    
    //Helper function for Saving Image to User Defaults
    func documentsPathForFileName(name: String) -> URL {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true);
        let path = paths[0] as String;
        let fullPath = URL(fileURLWithPath: path).appendingPathComponent(name)
        
        return fullPath
    }
    
    //MARK: Write Image to Firebase Storage
    //Writes image to Storage and Returns the imageURL where it is stored for use in FireStore
    func sendImageToStorage(photoData: Data) -> String {
        let imagePath = "images/" + Auth.auth().currentUser!.uid + "/\(Double(Date.timeIntervalSinceReferenceDate*1000)).jpg"
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        storageRef.child(imagePath).putData(photoData, metadata:metadata) {
            (metadata,error) in
            if let error = error {
                print("error uploading: \(error)")
                return
            }
            
        }
        return storageRef.child((metadata.path)!).description
    }
    
    
    
    //MARK: Logout Helpers
    private func forceSignOut(){
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    private func removeUserDefaults(){
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
    
    
    
    
    
    
    
    var myArray = [Object]()
    
    //MARK: FireStore And Storage Image Loading
    private func myDatabaseListener(completion: @escaping ()->()) {
        
        //Add dispatch group to control loading
        let myGroup = DispatchGroup()
        let myRef = db.collection("myCollection")
        let query = myRef.whereField("myCollection", isEqualTo: "decidingVariable")
        print("firing up Listener")
        //  //PULL DOCUMENTS WITHOUT LISTENER
        //            query.getDocuments() { (querySnapshot, err) in
        //                if let err = err {
        //                    print("Error getting documents: \(err)")
        //                }
        //
        
        // myRef.addSnapshotListener
        query.addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            
            for document in querySnapshot!.documents {
                
                if document.exists{
                    
                    //Adding to dispatch group the following stuff after enter
                    myGroup.enter()
                    
                    var myID = document.documentID
                    print("DocumentID: \(myID)")
                    let cd = document.data()
                    var image: UIImage?
                    
                    //Adding another dispatchGroup to handle image loading so everything is done within the parent dispatch. I think this is super dirty.
                    let secondGroup = DispatchGroup()
                    
                    if let imageURL = cd["image"] as? String{
                        print("imageURL is \(imageURL)")
                        secondGroup.enter()
                        var imageV = UIImageView()
                        
                        let storageRef = Storage.storage().reference(forURL: imageURL)
                        imageV.sd_setImage(with: storageRef, placeholderImage: UIImage(named: "placeholder.png"))
                        secondGroup.leave()
                    }
                    else{
                        print("image url is nil")
                    }
                    
                    
                    
                    
                    secondGroup.notify(queue: .main){
                        print("image loading is done and now we are populating our object")
                        
                        let myObject = Object(initializers: "all the initializers we need")
                        
                        self.myArray += [myObject]
                        
                        myGroup.leave()
                    }
                    
                }
                else{
                    print("document does not exist")
                }
                
                
            }//End of Document Snapshots
            
            //Fire off the dispatch group and finish the function
            myGroup.notify(queue: .main){
                print("Finished all reads")
                print("Object count is \(self.objects.count)")
                
                //self.doneLoading = true
                //self.myCollectionView.reloadData()
                
                self.tableView.reloadData()
                completion()
                
            }
            
        } //End of Snapshot Listener
        
    }
    
    //MARK: Spinner Functions
    func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    
    
    func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
