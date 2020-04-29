//
//  ParkingViewController.swift
//  myCampus2ios
//
//  Created by Nea Virtanen on 28.4.2020.
//  Copyright © 2020 iosdev. All rights reserved.
//

import UIKit

class ParkingViewController: UIViewController {
    
    @IBOutlet weak var ParkingP10Top: UIView!
    @IBOutlet weak var ParkingP10Inside: UIView!
    @IBOutlet weak var ParkingP5: UIView!
    
    @IBOutlet weak var P10TLabel: UILabel!
    @IBOutlet weak var P10InsLabel: UILabel!
    @IBOutlet weak var P5Label: UILabel!
    
    var p10TopUsage = 0.92
    var p10InsideUsage = 0.34
    var p5usage = 0.73
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Parking P10 Percentages
        
        let circularPath = UIBezierPath(arcCenter: ParkingP10Top.center, radius: 50, startAngle: -.pi  / 2, endAngle: 3 * .pi / 2, clockwise: true)
            
        let shapeLayerP10Top = CAShapeLayer()
        shapeLayerP10Top.path = circularPath.cgPath
        shapeLayerP10Top.strokeColor = UIColor.white.cgColor
        shapeLayerP10Top.lineWidth = 5
        shapeLayerP10Top.strokeEnd = 0
        shapeLayerP10Top.lineCap = .round
        shapeLayerP10Top.fillColor = UIColor.clear.cgColor
        
        view.layer.addSublayer(shapeLayerP10Top)
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        P10TLabel.text = "\(Double(p10TopUsage))%"
        P10TLabel.textAlignment = .center
        basicAnimation.toValue = p10TopUsage
        basicAnimation.duration = 2
        
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayerP10Top.add(basicAnimation, forKey: "parking1oTop")
        
        
        // Parking P10 Inside Percentage
        
        let p10InsideCircularPath = UIBezierPath(arcCenter: ParkingP10Inside.center, radius: 50, startAngle: -.pi  / 2, endAngle: 3 * .pi / 2, clockwise: true)
                
        let shapeLayerP10Inside = CAShapeLayer()
        shapeLayerP10Inside.path = p10InsideCircularPath.cgPath
        shapeLayerP10Inside.strokeColor = UIColor.white.cgColor
        shapeLayerP10Inside.lineWidth = 5
        shapeLayerP10Inside.strokeEnd = 0
        shapeLayerP10Inside.lineCap = .round
        shapeLayerP10Inside.fillColor = UIColor.clear.cgColor
        
        view.layer.addSublayer(shapeLayerP10Inside)
        
        let p10InsideBasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        P10InsLabel.text = "\(Double(p10InsideUsage))%"
        P10InsLabel.textAlignment = .center
        p10InsideBasicAnimation.toValue = p10InsideUsage
        p10InsideBasicAnimation.duration = 2
        
        p10InsideBasicAnimation.fillMode = .forwards
        p10InsideBasicAnimation.isRemovedOnCompletion = false
        
        shapeLayerP10Inside.add(p10InsideBasicAnimation, forKey: "parking10Inside")
        
        
        // Parking P5 Animation
        
              let p5CircularPath = UIBezierPath(arcCenter: ParkingP5.center, radius: 50, startAngle: -.pi  / 2, endAngle: 3 * .pi / 2, clockwise: true)
                      
              let shapeLayerP5 = CAShapeLayer()
              shapeLayerP5.path = p5CircularPath.cgPath
              shapeLayerP5.strokeColor = UIColor.white.cgColor
              shapeLayerP5.lineWidth = 5
              shapeLayerP5.strokeEnd = 0
              shapeLayerP5.lineCap = .round
              shapeLayerP5.fillColor = UIColor.clear.cgColor
              
              view.layer.addSublayer(shapeLayerP5)
              
              let p5BasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        
              P5Label.text = "\(Double(p5usage))%"
              P5Label.textAlignment = .center
              p5BasicAnimation.toValue = p5usage
              p5BasicAnimation.duration = 2
              
              p5BasicAnimation.fillMode = .forwards
              p5BasicAnimation.isRemovedOnCompletion = false
              
              shapeLayerP5.add(p5BasicAnimation, forKey: "parking5")
        
    }
    
}
