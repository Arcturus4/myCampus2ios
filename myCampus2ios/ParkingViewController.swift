//
//  ParkingViewController.swift
//  myCampus2ios
//
//  Created by Nea Virtanen on 28.4.2020.
//  Copyright © 2020 iosdev. All rights reserved.
//

import UIKit
import MBCircularProgressBar

class ParkingViewController: UIViewController {
    
    @IBOutlet weak var ParkingStackView: UIStackView!
    
    @IBOutlet weak var ParkingP5: UIView!
    @IBOutlet weak var ParkinP5Progress: MBCircularProgressBarView!
    
    @IBOutlet weak var ParkingP10Top: UIView!
    @IBOutlet weak var ParkingP10TopProgress: MBCircularProgressBarView!
    
    @IBOutlet weak var ParkingP10Inside: UIView!
    @IBOutlet weak var ParkingP10InsideProgress: MBCircularProgressBarView!
    
    @IBOutlet weak var ParkingElectric: UIView!
    @IBOutlet weak var ParkingElectricProgress: MBCircularProgressBarView!
    
    //Progress Values
    var P5Progress = 13
    var p10TopProgress = 24
    var P10InsideProgress = 45
    var ElectricProgress = 67
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initialize Animations
        self.ParkinP5Progress.value = 0
        self.ParkingP10TopProgress.value = 0
        self.ParkingP10InsideProgress.value = 0
        self.ParkingElectricProgress.value = 0
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //Animate Progresses
        UIView.animate(withDuration: 5) {
            self.ParkinP5Progress.value = CGFloat(self.P5Progress)
            self.ParkingP10TopProgress.value = CGFloat(self.p10TopProgress)
            self.ParkingP10InsideProgress.value = CGFloat(self.P10InsideProgress)
            self.ParkingElectricProgress.value = CGFloat(self.ElectricProgress)
        }
    }
}
