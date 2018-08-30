//
//  ThirdViewController.swift
//  VerbalFlashCards
//
//  Created by Richard Frnka on 4/26/18.
//  Copyright © 2018 Richard Frnka. All rights reserved.
//
//https://www.majortests.com/sat/wordlist-02
//Actual flipping of the cards here.
//I was trying to get the container view to resize on flipping, but it generally doesn't work. I put it inside a holderView to flip that and then resize the view inside it and re-anchor, but was pretty sloppy about it. On another note, by spamming the new card action and then flipping the card, it resized a few times in an unexpected way. More to come perhaps.

import UIKit

class ThirdViewController: UIViewController {
    
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var flipButton: UIButton!
    
    //@IBOutlet weak var holderView: UIView!
  
    @IBOutlet weak var containerView: UIView!
    
    var data:[[String:String]] = []
    var columnTitles:[String] = []
    
    var myDict = [Int:[String:String]]()
    var word: String?
    var definition: String?
    var myBool:Bool = false
    @IBAction func trigger(_ sender: Any) {
        if !myBool {
            if definition != nil{
                //containerView.frame = CGRect(x:0, y: 0, width: 400, height: 500)
                //containerView.backgroundColor = UIColor.green
            myLabel.text = definition!
            flipButton.titleLabel?.text = "Back to Word"
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
                flipButton.titleLabel?.text = "See Definition"
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
        assignBackground()
        createDictionary { () -> () in
            setupCard()
        }
        
    }
    func assignBackground(){
        let background = UIImage(named: "Gradient21")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        imageView.alpha = 1.0
        view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
    }
    func setupCard(){
        let seed = Int(1 + arc4random_uniform(UInt32(myDict.count - 1)))
        word = myDict[seed]!["word"]
        definition = myDict[seed]!["definition"]
        myLabel.font = UIFont.boldSystemFont(ofSize: 25.0)
        myLabel.text = "\(word!)"
        //label.font = UIFont.systemFont(ofSize: 20.0)
        
    }
    /*
    func launchFirstCard(){
        
        if data == []{
            print("What the heck")
        }
        else{
            print("would be launching first card here")
            let seed = Int(arc4random_uniform(UInt32(data.count)))
            word.text = myDict[seed]!["word"]!
            definition.text = backToCommas(myStr: myDict[seed]!["definition"]!)
            
        }
    }
 */
    func createDictionary(completion: () -> ()){
        let myString = readDataFromFile(file: "First65Words")
        
        //print(myString)
        if myString != nil{
            convertCSV(file: myString!)
            print(myDict)
            
        }
        
        completion()
    }
    
    
    func readDataFromFile(file:String)-> String!{
        guard let filepath = Bundle.main.path(forResource: file, ofType: "txt")
            else {
                return nil
        }
        do {
            let contents = try String(contentsOfFile: filepath)
            return contents
        } catch {
            print("File Read Error for file \(filepath)")
            return nil
        }
    }
    
    func cleanRows(file:String)->String{
        var cleanFile = file
        cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
        cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
        cleanFile = cleanFile.replacingOccurrences(of: ", ", with: ",")
        return cleanFile
    }
    func backToCommas(myStr: String)->String{
        var cleanString = myStr
        cleanString = cleanString.replacingOccurrences(of: ";", with: ",")
        return cleanString
    }
    func convertCSV(file:String){
        let rows = cleanRows(file:file).components(separatedBy:"\n")
        if rows.count > 0 {
            data = []
            columnTitles = getStringFieldsForRow(row: rows.first!,delimiter:",")
            for row in rows.dropFirst(){
                
                let fields = getStringFieldsForRow(row:row,delimiter: ",")
                if fields.count != columnTitles.count {continue}
                let ind:Int! = Int(fields[0])
                print(ind)
                var dataRow = [String:String]()
                for (index,field) in fields.enumerated(){
                    if index == 0{
                        continue
                    }
                    else{
                        let fieldName = columnTitles[index]
                        dataRow[fieldName] =  backToCommas(myStr: field)
                    }
                    
                }
                myDict[ind] = dataRow
                data += [dataRow]
            }
        } else {
            print("No data in file")
        }
    }
    func getStringFieldsForRow(row:String, delimiter:String)-> [String]{
        return row.components(separatedBy: delimiter)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
