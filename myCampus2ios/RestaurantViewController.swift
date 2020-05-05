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


class RestaurantViewController: UIViewController, TokenDelegate {
    

    @IBOutlet weak var RestaurantMainView: UIView!
    
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
    
    func setToken(token: String) {
        print("SetToken")
        restaurantData()
    }
    
<<<<<<< HEAD
    
    var Favorites1Percent = 0.0
    var Favorites2Percent = 0.0
    var PizzaPercent = 0.0
    var RoundTablePercent = 0.0
    var BowlPercent = 0.0
    var VegePercent = 0.0
    var CafePickupLinePercent = 0.0
    var SaladPercent = 0.00

    
    override func viewDidLoad() {
        super.viewDidLoad()
        (UIApplication.shared.delegate as! AppDelegate).tokenDelegate = self
        restaurantData()

        RestaurantMainView.layer.cornerRadius = 10
        RestaurantMainView.layer.masksToBounds = true
    
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
    
    let first = URL(staticString: "https://mycampus-server.karage.fi/api/common/restaurant/Midpoint/queue/1")
            let second = URL(staticString: "https://mycampus-server.karage.fi/api/common/restaurant/Midpoint/queue/2")
            let third = URL(staticString: "https://mycampus-server.karage.fi/api/common/restaurant/Midpoint/queue/3")
            let fourth = URL(staticString: "https://mycampus-server.karage.fi/api/common/restaurant/Midpoint/queue/4")
            let fifth = URL(staticString: "https://mycampus-server.karage.fi/api/common/restaurant/Midpoint/queue/5")
            let sixth = URL(staticString: "https://mycampus-server.karage.fi/api/common/restaurant/Midpoint/queue/6")
            let seventh = URL(staticString: "https://mycampus-server.karage.fi/api/common/restaurant/Midpoint/queue/7")
            let eight = URL(staticString: "https://mycampus-server.karage.fi/api/common/restaurant/Midpoint/queue/8")
            
            func restaurantData(){
            print("parking1")
            let delegate = (UIApplication.shared.delegate as! AppDelegate)
            let token = delegate.token
            
                let urls : [URL] = [first, second, third, fourth, fifth, sixth, seventh, eight]
            
            for (indexx, element) in urls.enumerated() {
              print("Item \(indexx): \(element)")
            
            
            var request = URLRequest(url: element)
            request.setValue(token, forHTTPHeaderField: "Authorization")
            request.httpMethod = "GET"
            
            //let session = URLSession(configuration: URLSessionConfiguration.default)
            
            let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
                if let error = error {
                    print("client error: ", error)
                }
                guard let httpResponse = response as? HTTPURLResponse,
                    (200...299).contains(httpResponse.statusCode) else {
                        //handle server error
                        
                        //let UI = UIFont()s
                        
                        //self.showToast(message: "response not in 200 range", font: UI)
                        return
                }
                
                if let httpresponse = response as? HTTPURLResponse {
                    print(httpresponse.statusCode)
                    print(httpresponse)
                //if let response = data as? HTTPURLResponse{
                    //print(response.statusCode)
                }
                if let data = data, let string = String(data: data, encoding: .utf8) {
                    //process data

                    print(data, "datacheck")
                        

                    print(data)
                
                    
                    let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]

                    
                        //!xyMycampus2020
                       
                    var item = ""
                        let jsons = try? JSONSerialization.jsonObject(with: data, options: [])
                        
                        if let dictionary = jsons as? [String: Any] {
                            
                        if let value = dictionary["queue_time"] as? String {
                            do{
                                item = value
                                print("indexed at: ", indexx, " with time value of: ", item)
                            }
                            }
                        }
                    
                    
                    print("data: \(data) string:\(string)")
                    DispatchQueue.main.async {
                        
                        if let wre:Int = Int(item){
                            if let wree:Double = Double(wre){
                        
                    
                            switch indexx {
                            //witch self.index(ofAccessibilityElement: AnyIndex.self) {
                            case 0 : print("timeq1", item)
                            self.Favorites1Percent = ((Double)(wree/100) * Double(CGFloat(20)))
                            self.Favourites1.progressValue = 1
                            self.Favourites1.setProgress(progress: CGFloat(self.Favorites1Percent), animated: true)
                                
                            case 1 : print("timeq2", item)
                            self.Favourites2.progressValue = 1
                                self.Favorites2Percent = ((Double)(wree/100) * Double(CGFloat(20)))
                                self.Favourites2.setProgress(progress: CGFloat(self.Favorites2Percent), animated: true)
                                
                            case 2 : print("timeq3", item)
                            self.Pizza.progressValue = 1
                            self.RoundTablePercent = ((Double)(wree/100) * Double(CGFloat(20)))
                                self.Pizza.setProgress(progress: CGFloat(self.PizzaPercent), animated: true)
                                
                            case 3 : print("timeq4", item)
                            self.RoundTable.progressValue = 1
                                self.RoundTablePercent = ((Double)(wree/100) * Double(CGFloat(20)))
                                self.RoundTable.setProgress(progress: CGFloat(self.RoundTablePercent), animated: true)
                                
                            case 4 : print("timeq5", item)
                            self.Bowl.progressValue = 1
                                self.BowlPercent = ((Double)(wree/100) * Double(CGFloat(20)))
                                self.Bowl.setProgress(progress: CGFloat(self.BowlPercent), animated: true)
                                
                            case 5 : print("timeq6", item)
                            self.Vege.progressValue = 1
                                self.VegePercent = ((Double)(wree/100) * Double(CGFloat(20)))
                            self.Vege.setProgress(progress: CGFloat(self.VegePercent), animated: true)
                                
                            case 6 : print("timeq7", item)
                            self.CafePickupLine.progressValue = 1
                                self.CafePickupLinePercent = ((Double)(wree/100) * Double(CGFloat(20)))
                                self.CafePickupLine.setProgress(progress: CGFloat(self.CafePickupLinePercent), animated: true)
                                
                            case 7 : print("timeq8", item)
                            self.Salad.progressValue = 1
                                self.SaladPercent = ((Double)(wree/100) * Double(CGFloat(20)))
                                self.Salad.setProgress(progress: CGFloat(self.SaladPercent), animated: true)
                                
                            default : break
                            }
                    }
                    }
                    }
                }
            })
            task.resume()
            }
        }
    }
