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
    
    var p10TopUsage = 0.92
    var p10InsideUsage = 0.34
    var p5usage = 0.73
    


    let p10TopPercentageLabel: UILabel = {
        let label = UILabel()
        label.text = "Usage"
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    let p10InsidePercentageLabel: UILabel = {
        let label = UILabel()
        label.text = "Usage"
        label.textAlignment = NSTextAlignment.center
        return label
    }()

    let p5PercentageLabel: UILabel = {
        let label = UILabel()
        label.text = "Usage"
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Parking P10 Percentages
        
        ParkingP10Top.addSubview(p10TopPercentageLabel)
        p10TopPercentageLabel.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        p10TopPercentageLabel.center = ParkingP10Top.center
        p10TopPercentageLabel.textColor = .white

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
        
        basicAnimation.toValue = p10TopUsage
        basicAnimation.duration = 2
        
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayerP10Top.add(basicAnimation, forKey: "parking1oTop")
        
        // Parking P10 Inside Percentage
        
        ParkingP10Inside.addSubview(p10InsidePercentageLabel)
        p10InsidePercentageLabel.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        p10InsidePercentageLabel.center = ParkingP10Inside.center
        p10InsidePercentageLabel.textColor = .white
        
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
        
        p10InsideBasicAnimation.toValue = p10InsideUsage
        p10InsideBasicAnimation.duration = 2
        
        p10InsideBasicAnimation.fillMode = .forwards
        p10InsideBasicAnimation.isRemovedOnCompletion = false
        
        shapeLayerP10Inside.add(p10InsideBasicAnimation, forKey: "parking10Inside")
        
        
        // Parking P5 Animation
        
        ParkingP5.addSubview(p5PercentageLabel)
              p5PercentageLabel.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
              p5PercentageLabel.center = ParkingP5.center
              p5PercentageLabel.textColor = .white
              
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
              
              p5BasicAnimation.toValue = p5usage
              p5BasicAnimation.duration = 2
              
              p5BasicAnimation.fillMode = .forwards
              p5BasicAnimation.isRemovedOnCompletion = false
              
              shapeLayerP5.add(p5BasicAnimation, forKey: "parking5")
        
    }
    
}
