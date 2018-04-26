//
//  ViewController.swift
//  VerbalFlashCards
//
//  Created by Richard Frnka on 4/26/18.
//  Copyright © 2018 Richard Frnka. All rights reserved.
//
//Credit to J. Doe on Stack overflow for the super-simple flip animation pointer
//https://stackoverflow.com/questions/39519102/ios-card-flip-animation

//Credit to Steven Lipton for the introduction to reading in CSV's/Text files into Swift.
//https://makeapppie.com/2016/05/23/reading-and-writing-text-and-csv-files-in-swift/

//The next step would be to store the dictionary in CoreData rather than having to read it in from the txt file over and over again.
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    
    var data:[[String:String]] = []
    var columnTitles:[String] = []
    private let backImageView: UIImageView! = UIImageView(image: UIImage(named: "back"))
    private let frontImageView: UIImageView! = UIImageView(image: UIImage(named: "front"))
    var myDict = [Int: [String:String]]()
    
    
    
    
    @IBOutlet weak var definition: UILabel!
    
    @IBOutlet weak var word: UILabel!
    
    @IBAction func button2(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "third") as! ThirdViewController
        vc.myDict = myDict
        if self.navigationController != nil{
            self.navigationController?.show(vc, sender: nil)
        }
        else
        {
            self.present(vc, animated: true)
        }
    }
    @IBAction func buttonClick(_ sender: Any) {
        print("button clicked")
        let seed = Int(arc4random_uniform(UInt32(data.count - 1))) + 1
        word.text = myDict[seed]!["word"]!
        definition.text = myDict[seed]!["definition"]!
        containerView.setNeedsLayout()
    }
    
    
    func clearNavBar(){
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearNavBar()
        createDictionary { () -> () in
            launchFirstCard()
        }
        
    }
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

