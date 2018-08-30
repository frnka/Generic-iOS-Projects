//
//  MinorViewController.swift
//  GraphTheory
//
//  Created by Richard Frnka on 5/31/18.
//  Copyright © 2018 Richard Frnka. All rights reserved.
//

import UIKit

class MinorViewController: UIViewController {
    var myMatrix = [[Int]]()
    var myPoints = [CGPoint]()

    var thePoints = [CGPoint]()
    var theMatrix = [[Int]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let v = 7
        let e = 15
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
        
        createGraph(v:v, e:e)
        
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
            print(x,y)
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
        print(thePoints)
        drawLines(mat: myMatrix, points: points)
        
        
        
        
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
                    line.lineWidth = 3
                    line.lineJoin = kCALineJoinRound
                    line.bounds = (line.path?.boundingBox)!
                    drawnLines += [line]
                    self.view.layer.addSublayer(line)
                }
            }
        }
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        guard let point = touch?.location(in: self.view) else { return }
        guard let sublayers = self.view.layer.sublayers as? [CAShapeLayer] else { return }
        
        for layer in sublayers{
            if let path = layer.path, path.contains(point) {
                print(layer)
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
    
    
    
}
