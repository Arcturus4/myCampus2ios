//
//  RestaurantViewController.swift
//  myCampus2ios
//
//  Created by Nea Virtanen on 28.4.2020.
//  Copyright © 2020 iosdev. All rights reserved.
//

import UIKit
import MBCircularProgressBar
import AMProgressBar


class RestaurantViewController: UIViewController {
    
    

    @IBOutlet weak var RestaurantMainView: UIView!
    @IBOutlet weak var RestaurantUtilisationMain: MBCircularProgressBarView!
    
    @IBOutlet weak var Favourites1: AMProgressBar!
    @IBOutlet weak var Favourites2: AMProgressBar!
    @IBOutlet weak var Pizza: AMProgressBar!
    @IBOutlet weak var RoundTable: AMProgressBar!
    @IBOutlet weak var Bowl: AMProgressBar!
    @IBOutlet weak var Vege: AMProgressBar!
    @IBOutlet weak var CafePickupLine: AMProgressBar!
    @IBOutlet weak var Salad: AMProgressBar!
    
    @IBOutlet weak var Favourites1Label: UILabel!
    @IBOutlet weak var Favourites2Label: UILabel!
    @IBOutlet weak var PizzaLabel: UILabel!
    @IBOutlet weak var RoundTableLabel: UILabel!
    @IBOutlet weak var BowlLabel: UILabel!
    @IBOutlet weak var VegeLabel: UILabel!
    @IBOutlet weak var CafePickupLabel: UILabel!
    @IBOutlet weak var SaladLabel: UILabel!
    
    
    var Favorites1Percent = 0.46
    var Favorites2Percent = 0.63
    var PizzaPercent = 0.76
    var RoundTablePercent = 0.87
    var BowlPercent = 0.96
    var VegePercent = 0.26
    var CafePickupLinePercent = 0.42
    var SaladPercent = 0.52
    

    var RestaurantUsagePercent = 28
    
    override func viewDidLoad() {
        super.viewDidLoad()

        RestaurantMainView.layer.cornerRadius = 10
        RestaurantMainView.layer.masksToBounds = true
        
        self.RestaurantUtilisationMain.value = 0
    
        Favourites1.progressValue = 1
        Favourites1.setProgress(progress: CGFloat(Favorites1Percent), animated: true)
        
        Favourites2.progressValue = 1
        Favourites2.setProgress(progress: CGFloat(Favorites2Percent), animated: true)
        
        Pizza.progressValue = 1
        Pizza.setProgress(progress: CGFloat(PizzaPercent), animated: true)
        
        RoundTable.progressValue = 1
        RoundTable.setProgress(progress: CGFloat(RoundTablePercent), animated: true)
        
        Bowl.progressValue = 1
        Bowl.setProgress(progress: CGFloat(BowlPercent), animated: true)

        Vege.progressValue = 1
        Vege.setProgress(progress: CGFloat(VegePercent), animated: true)
        
        CafePickupLine.progressValue = 1
        CafePickupLine.setProgress(progress: CGFloat(CafePickupLinePercent), animated: true)
        
        Salad.progressValue = 1
        Salad.setProgress(progress: CGFloat(SaladPercent), animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: 2) {
            self.RestaurantUtilisationMain.value = CGFloat(self.RestaurantUsagePercent)
        }
    }
}
