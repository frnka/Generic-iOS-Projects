//
//  ThirdViewController.swift
//  VerbalFlashCards
//
//  Created by Richard Frnka on 4/26/18.
//  Copyright © 2018 Richard Frnka. All rights reserved.
//

//Actual flipping of the cards here.
//I was trying to get the container view to resize on flipping, but it generally doesn't work. I put it inside a holderView to flip that and then resize the view inside it and re-anchor, but was pretty sloppy about it. On another note, by spamming the new card action and then flipping the card, it resized a few times in an unexpected way. More to come perhaps.

import UIKit

class ThirdViewController: UIViewController {
    
    
    
    //@IBOutlet weak var holderView: UIView!
    
    @IBOutlet weak var myLabel: UILabel!
    var myDict = [Int:[String:String]]()
    var word: String?
    var definition: String?
    @IBOutlet weak var containerView: UIView!
    var myBool:Bool = false
    @IBAction func trigger(_ sender: Any) {
        if !myBool {
            if definition != nil{
                //containerView.frame = CGRect(x:0, y: 0, width: 400, height: 500)
                //containerView.backgroundColor = UIColor.green
            myLabel.text = definition!
            myLabel.font = UIFont.systemFont(ofSize: 20.0)
                myLabel.textAlignment = .right
                //holderView.addSubview(containerView)
            }
            UIView.transition(with: containerView, duration: 2, options: .transitionFlipFromRight, animations: nil, completion: nil)
        }
        else {
            
            if word != nil{
                //containerView.frame = CGRect(x:50, y: 50, width: 400, height: 200)
                //containerView.backgroundColor = UIColor.red
                myLabel.font = UIFont.boldSystemFont(ofSize: 25.0)
                myLabel.text = word!
                myLabel.textAlignment = .center
                //holderView.addSubview(containerView)
                UIView.transition(with: containerView, duration: 2, options: .transitionFlipFromRight, animations: nil, completion: nil)
            }
            
        }
        myBool = !myBool
    }
    
    @IBAction func newCard(_ sender: Any) {
        setupCard()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCard()
        
    }
    func setupCard(){
        let seed = Int(1 + arc4random_uniform(UInt32(myDict.count - 1)))
        word = myDict[seed]!["word"]
        definition = myDict[seed]!["definition"]
        myLabel.font = UIFont.boldSystemFont(ofSize: 25.0)
        myLabel.text = "\(word!)"
        //label.font = UIFont.systemFont(ofSize: 20.0)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
