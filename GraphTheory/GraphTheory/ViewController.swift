//
//  ViewController.swift
//  GraphTheory
//
//  Created by Richard Frnka on 5/3/18.
//  Copyright © 2018 Richard Frnka. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    var v:Int?
    var e:Int?
    var thePoints = [CGPoint]()
    var theMatrix = [[Int]]()
    @IBOutlet weak var vert: UITextField!
    
    @IBOutlet weak var edge: UITextField!
    
    @IBAction func buttonClicked(_ sender: Any) {
        for i in drawnLines{
            i.removeFromSuperlayer()
        }
        drawnLines = []
        createGraph(v:v!, e: e!)
        
        print("button Tapped")
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(textField.text)
        if textField == vert {
            
            if let myInt:Int = Int(textField.text!){
                v = myInt
                
            }
        }
        else if textField == edge {
            if let myInt:Int = Int(textField.text!){
                e = myInt
                
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.hideKeyboard()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        vert.delegate = self
        edge.delegate = self
        v = 20
        e = 100
        let w = self.view.frame.size.width
        let rad = 0.45*w
        let h = self.view.frame.size.height
        /*
        let button = UIButton(frame: CGRect(x: (w / 2) - 75, y: h-200, width: 150, height: 50))
        button.backgroundColor = .green
        button.titleLabel?.text = "Change Graph"
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        self.view.addSubview(button)
 */
        
        createGraph(v:v!, e:e!)
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func createGraph(v: Int, e: Int){
        let w = self.view.frame.size.width
        let rad = 0.45*w
        let h = self.view.frame.size.height
        var points = [CGPoint]()
        for i in 0...v-1 {
            
            let theta = CGFloat(Double(i) * Double.pi * 2.0 / Double(v))
            let x = rad * cos(theta) + w/2
            let y = rad * sin(theta) + w/2 + 100
            let myPoint = CGPoint(x: x, y: y)
            points += [myPoint]
            
            createVertices(center: myPoint)
        }
        var sum = 0
        var myMatrix = initializeMatrix(v: v)
        
        
        while sum < e{
            
            
            for j in 0...v-1{
                for k in 0...v-1{
                    let unit = Int(arc4random()%2)
                    if myMatrix[j][k] == 0{
                        sum += unit
                        if sum == e-1{break}
                        else
                        {
                            myMatrix[j][k] += unit
                        }
                    }
                    
                    
                }
            }
        }
        print( myMatrix)
        thePoints = points
        drawLines(mat: myMatrix, points: points)
        
        
        
        
    }
    @objc func buttonAction(){
        for i in drawnLines{
            i.removeFromSuperlayer()
        }
        drawnLines = []
        createGraph(v:v!, e: e!)
        
        print("button Tapped")
    }
    var drawnLines = [CAShapeLayer]()
    func drawLines(mat: [[Int]], points: [CGPoint]){
        //let ctx:CGContext = UIGraphicsGetCurrentContext()
        
        for (i,row) in mat.enumerated() {
            for (j,spot) in row.enumerated(){
                if spot != 0 {
                    
                    let point1 = points[i]
                    let point2 = points[j]
                    let line = CAShapeLayer()
                    let linePath = UIBezierPath()
                    linePath.move(to: point1)
                    linePath.addLine(to: point2)
                    line.path = linePath.cgPath
                    line.strokeColor = UIColor.black.cgColor
                    line.lineWidth = 1
                    line.lineJoin = kCALineJoinRound
                    drawnLines += [line]
                    self.view.layer.addSublayer(line)
                    }
            }
        }
        
        
    }
    func initializeMatrix(v: Int) -> [[Int]]{
        var NumColumns = v
        var NumRows = v
        var array = Array<Array<Int>>()
        for column in 0...NumColumns {
            array.append(Array(repeating:0, count:NumRows))
        }
        print(array)
        return array
    }
    func createVertices(center: CGPoint){
        
        let circlePath = UIBezierPath(arcCenter: center, radius: CGFloat(10), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        
        //change the fill color
        shapeLayer.fillColor = UIColor.black.cgColor
        //you can change the stroke color
        shapeLayer.strokeColor = UIColor.black.cgColor
        //you can change the line width
        shapeLayer.lineWidth = 3.0
        
        view.layer.addSublayer(shapeLayer)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y = 0
            }
        }
    }
    

}
