//
//  NewMinorsViewController.swift
//  GraphTheory
//
//  Created by Richard Frnka on 5/31/18.
//  Copyright © 2018 Richard Frnka. All rights reserved.
//

import UIKit

class NewMinorsViewController: UIViewController {
    var v:Int?
    var e:Int?
    var thePoints = [CGPoint]()
    var theMatrix = [[Int]]()
    var currLayer: CALayer?
    var myDict = [CALayer: [Int]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.hideKeyboard()
        //NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        //NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        //vert.delegate = self
        //edge.delegate = self
        v = 8
        e = 30
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        guard let point = touch?.location(in: self.view) else { return }
        guard let sublayers = self.view.layer.sublayers as? [CAShapeLayer] else { return }
        
        for layer in sublayers{
            if let path = layer.path, path.contains(point) {
                print(layer)
                
                if let myLayer = self.currLayer{
                    if myLayer == layer {
                        //removeVertex
                        layer.strokeColor = UIColor.red.cgColor
                        if let i = drawnPoints.index(of: layer) {
                            print(i)
                            self.removeVertex(i: i)
                        }
                    }
                    else{
                        currLayer = layer
                        layer.strokeColor = UIColor.green.cgColor
                    }
                    
                }
                else{
                    currLayer = layer
                    layer.strokeColor = UIColor.green.cgColor
                }
                
                
            }
        }
    }
    func removeVertex(i: Int)
    {
        drawnPoints[i].removeFromSuperlayer()
        for layer in drawnLines{
            if (myDict[layer]?.contains(i))!{
                layer.removeFromSuperlayer()
            }
        }
        
    }
    var drawnPoints = [CAShapeLayer]()
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
                    linePath.move(to: point2)
                    linePath.addLine(to: point1)
                    line.path = linePath.cgPath
                    print("LINE PATH: \(line.path)")
                    print("Bounding Box: \(line.path?.boundingBoxOfPath)")
                    //line.bounds = line.path!.boundingBoxOfPath
                    //line.bounds = CGRect(x: (line.path?.boundingBoxOfPath.minX)!, y: (line.path?.boundingBoxOfPath.minY)!, width: (line.path?.boundingBoxOfPath.maxX)! - (line.path?.boundingBoxOfPath.minX)!, height:  (line.path?.boundingBoxOfPath.maxY)! - (line.path?.boundingBoxOfPath.minY)!)
                    line.strokeColor = UIColor.black.cgColor
                    line.lineWidth = 1
                    print("LINE BOUNDS: \(line.bounds)")
                    //line.bounds = (line.path?.boundingBox)!
                    line.lineJoin = kCALineJoinRound
                    drawnLines += [line]
                    myDict[line] = [i,j]
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
        drawnPoints += [shapeLayer]
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
