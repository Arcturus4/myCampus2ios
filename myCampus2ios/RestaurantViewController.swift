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

//Class contains method for accessing restaurant queue data on API, a custom protocol for making
//sure the token has been set and references to UI components
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
    
    // process api response in range 1-5 for desired time estimates and display them in labels
    
    func queueTime(value: Int, label: UILabel, actualName: String) {
        var name = label
        switch value {
        case 1: name.text =  "\(actualName), time: 0-30s"
        case 2: name.text = "\(actualName), time: 30-60s"
        case 3: name.text = "\(actualName),  time: 1m-1m30s"
        case 4:  name.text = "\(actualName),  time: 1m30s-2m"
        case 5: name.text = "\(actualName),  time: 2m - 2m30s"
            
        default:
            break
        }
    }
    // Access API data on current restaurant queues
    func restaurantData(){
        print("parking1")
        //JWT
        let delegate = (UIApplication.shared.delegate as! AppDelegate)
        let token = delegate.token
        
        //Endpoints
        let urls : [URL] = [first, second, third, fourth, fifth, sixth, seventh, eight]
        
        //for each endpoint
        for (indexx, element) in urls.enumerated() {
            print("Item \(indexx): \(element)")
            
            //make a request
            var request = URLRequest(url: element)
            request.setValue(token, forHTTPHeaderField: "Authorization")
            request.httpMethod = "GET"
            
            //create URL session
            let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
                if let error = error {
                    print("client error: ", error)
                }
                guard let httpResponse = response as? HTTPURLResponse,
                    (200...299).contains(httpResponse.statusCode) else {
                        //handle server error
                        
                        //show alert if request fails
                        let alert = UIAlertController(title: "Error", message: "API not responding to request", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: { _ in
                            NSLog("API error: message not in range 200..299")
                        }))
                        self.present(alert, animated: true, completion: nil)
                        return
                }
                
                if let httpresponse = response as? HTTPURLResponse {
                    print(httpresponse.statusCode)
                    print(httpresponse)
                    //if let response = data as? HTTPURLResponse{
                    //print(response.statusCode)
                }
                //proceed to json decoding
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
                                //this is the value returned by API
                                item = value
                                print("indexed at: ", indexx, " with time value of: ", item)
                            }
                        }
                    }
                    
                    
                    print("data: \(data) string:\(string)")
                    
                    //use the data to populate UI
                    DispatchQueue.main.async {
                        
                        if let wre:Int = Int(item){
                            if let wree:Double = Double(wre){
                                
                                //set values corresponding to actionbar of the current index in urls
                                switch indexx {
                                //witch self.index(ofAccessibilityElement: AnyIndex.self) {
                                case 0 : print("timeq1", item)
                                //self.Favourites1Label.text = "Favourites 1"
                                self.queueTime(value: wre, label: self.Favourites1Label, actualName: "Favourites 1")
                                self.Favorites1Percent = ((Double)(wree/100) * Double(CGFloat(20)))
                                self.Favourites1.progressValue = 1
                                self.Favourites1.setProgress(progress: CGFloat(self.Favorites1Percent), animated: true)
                                    
                                case 1 : print("timeq2", item)
                                //elf.Favourites2Label.text = "Favourites 2"
                                self.queueTime(value: wre, label: self.Favourites2Label, actualName: "Favourites 2")
                                self.Favourites2.progressValue = 1
                                self.Favorites2Percent = ((Double)(wree/100) * Double(CGFloat(20)))
                                self.Favourites2.setProgress(progress: CGFloat(self.Favorites2Percent), animated: true)
                                    
                                case 2 : print("timeq3", item)
                                
                                self.queueTime(value: wre, label: self.PizzaLabel, actualName: "Pizza")
                                
                                self.Pizza.progressValue = 1
                                self.PizzaPercent = ((Double)(wree/100) * Double(CGFloat(20)))
                                self.Pizza.setProgress(progress: CGFloat(self.PizzaPercent), animated: true)
                                    
                                case 3 : print("timeq4", item)
                                //self.RoundTableLabel.text = "Round table"
                                self.queueTime(value: wre, label: self.RoundTableLabel, actualName: "Round table")
                                self.RoundTable.progressValue = 1
                                self.RoundTablePercent = ((Double)(wree/100) * Double(CGFloat(20)))
                                self.RoundTable.setProgress(progress: CGFloat(self.RoundTablePercent), animated: true)
                                    
                                case 4 : print("timeq5", item)
                                // self.BowlLabel.text = "Bowl"
                                self.queueTime(value: wre, label: self.BowlLabel, actualName: "Bowl")
                                self.Bowl.progressValue = 1
                                self.BowlPercent = ((Double)(wree/100) * Double(CGFloat(20)))
                                self.Bowl.setProgress(progress: CGFloat(self.BowlPercent), animated: true)
                                    
                                case 5 : print("timeq6", item)
                                //elf.VegeLabel.text = "Vege"
                                self.queueTime(value: wre, label: self.VegeLabel, actualName: "Vege")
                                self.Vege.progressValue = 1
                                self.VegePercent = ((Double)(wree/100) * Double(CGFloat(20)))
                                self.Vege.setProgress(progress: CGFloat(self.VegePercent), animated: true)
                                    
                                case 6 : print("timeq7", item)
                                //self.CafePickupLabel.text = "Cafe pickup line"
                                self.queueTime(value: wre, label: self.CafePickupLabel, actualName: "Cafe pickup line")
                                self.CafePickupLine.progressValue = 1
                                self.CafePickupLinePercent = ((Double)(wree/100) * Double(CGFloat(20)))
                                self.CafePickupLine.setProgress(progress: CGFloat(self.CafePickupLinePercent), animated: true)
                                    
                                case 7 : print("timeq8", item)
                                //self.SaladLabel.text = "Salad/nokia coffee.k"
                                self.queueTime(value: wre, label: self.SaladLabel, actualName: "Salad/nokia coffee.k")
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
