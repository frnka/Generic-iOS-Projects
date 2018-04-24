//
//  MultiplicationFlashCardViewController.swift
//
//  Created by Richard Frnka on 4/24/18.
//  Copyright © 2018 Richard Frnka. All rights reserved.
//

import UIKit
class MultiplicationFlashCardViewController: UIViewController {
   
    @IBOutlet weak var problemText: UILabel!
    @IBOutlet weak var buttonA: UIButton!
    
    @IBOutlet weak var buttonB: UIButton!
    
    @IBOutlet weak var buttonC: UIButton!
    
    @IBOutlet weak var buttonD: UIButton!
    
    var tries: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: self, action: #selector(goHome))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextProblem))
        let seed = Int(arc4random_uniform(1000))%4
        let a = 10+Int(arc4random_uniform(90))
        let b = 10+Int(arc4random_uniform(90))
        tries = 0
        
        makeProblem(a: a, b: b, seed: seed)
        
        // Do any additional setup after loading the view.
    }
    @objc func goHome(){
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    @objc func nextProblem(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "multi") as! MultiplicationFlashCardViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func makeProblem(a: Int, b: Int, seed: Int) {
        let answer = a*b
        problemText.text = "\(a) * \(b) = ?"
        let rand4 = 10 * (1 + Int(arc4random_uniform(10)))
        let rand1 = -1 - Int(arc4random_uniform(200))
        let rand2 = 1 + Int(arc4random_uniform(120))
        let rand3 =  Int(pow(Double(-1),Double(Int(arc4random_uniform(120))%2))) * (1+Int(arc4random_uniform(20)))
        let answerButton: UIButton?
        let myButtons:[UIButton] = [buttonA, buttonB, buttonC, buttonD]
        buttonA.addTarget(self, action: #selector(buttonClicked), for: UIControlEvents.touchUpInside)
        buttonB.addTarget(self, action: #selector(buttonClicked), for: UIControlEvents.touchUpInside)
        buttonC.addTarget(self, action: #selector(buttonClicked), for: UIControlEvents.touchUpInside)
        buttonD.addTarget(self, action: #selector(buttonClicked), for: UIControlEvents.touchUpInside)
        
        switch seed {
        case 0:
            print("answer is A")
            answerButton = buttonA
            buttonA.tag = 0
            buttonB.tag = 1
            buttonC.tag = 1
            buttonD.tag = 1
            buttonA.setTitle("A) \(answer)", for: .normal)
            buttonB.setTitle("B) \(answer + rand1)", for: .normal)
            buttonC.setTitle("C) \(answer + rand2)", for: .normal)
            buttonD.setTitle("D) \(answer + rand3)", for: .normal)
        case 1:
            print("answer is B")
            answerButton = buttonB
            buttonA.tag = 1
            buttonB.tag = 0
            buttonC.tag = 1
            buttonD.tag = 1
            buttonA.setTitle("A) \(answer + rand1)", for: .normal)
            buttonB.setTitle("B) \(answer)", for: .normal)
            buttonC.setTitle("C) \(answer + rand3)", for: .normal)
            buttonD.setTitle("D) \(answer + rand2)", for: .normal)
        case 2:
            print("answer is C")
            buttonA.tag = 1
            buttonB.tag = 1
            buttonC.tag = 0
            buttonD.tag = 1
            answerButton = buttonC
            buttonA.setTitle("A) \(answer + rand3)", for: .normal)
            buttonB.setTitle("B) \(answer + rand2)", for: .normal)
            buttonC.setTitle("C) \(answer)", for: .normal)
            buttonD.setTitle("D) \(answer + rand1)", for: .normal)
        case 3:
            print("answer is D")
            buttonA.tag = 1
            buttonB.tag = 1
            buttonC.tag = 1
            buttonD.tag = 0
            answerButton = buttonD
            buttonA.setTitle("A) \(answer + rand1)", for: .normal)
            buttonB.setTitle("B) \(answer + rand3)", for: .normal)
            buttonC.setTitle("C) \(answer + rand2)", for: .normal)
            buttonD.setTitle("D) \(answer)", for: .normal)
        default:
            print("Seed not anything. What's up?")
            answerButton = buttonA
            buttonA.tag = 0
            buttonB.tag = 1
            buttonC.tag = 1
            buttonD.tag = 1
            buttonA.setTitle("A) \(answer)", for: .normal)
            buttonB.setTitle("B) \(answer + rand1)", for: .normal)
            buttonC.setTitle("C) \(answer + rand2)", for: .normal)
            buttonD.setTitle("D) \(answer + rand3)", for: .normal)
        }
        /*
         for button in myButtons
         {
         if button == answerButton{
         button.addTarget(self,action:#selector(correctAnswer),
         for:.touchUpInside)
         }
         }
         */
        
        
    }
    @objc func buttonClicked(sender: UIButton) {
        switch sender.tag
        {
        case 0:
            print("Right Answer selected")
            sender.backgroundColor = UIColor.green
            buttonA.isUserInteractionEnabled = false
            buttonB.isUserInteractionEnabled = false
            buttonC.isUserInteractionEnabled = false
            buttonD.isUserInteractionEnabled = false
            let alert = UIAlertController(title: "50 points added!", message: "Let's try another problem.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "New Problem", style: .default, handler: { action in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "multi") as! MultiplicationFlashCardViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            
        case 1:
            print("Wrong Answer Selected")
            sender.backgroundColor = UIColor.red
            if tries != nil{
                if tries! < 1 {
                    tries = 1
                    let alert = UIAlertController(title: "Wrong Answer!", message: "Try Again", preferredStyle: .actionSheet)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    
                    
                    self.present(alert, animated: true)
                }
                else{
                    let alert = UIAlertController(title: "Wrong Answer!", message: "Out of Attempts", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Try another problem", style: .default, handler: { action in
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "multi") as! MultiplicationFlashCardViewController
                        self.navigationController?.pushViewController(vc, animated: true)
                    }))
                    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    buttonA.isUserInteractionEnabled = false
                    buttonB.isUserInteractionEnabled = false
                    buttonC.isUserInteractionEnabled = false
                    buttonD.isUserInteractionEnabled = false
                    self.present(alert, animated: true)
                    
                }
            }
        default:
            print("nothing is working")
            
        }
        
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
