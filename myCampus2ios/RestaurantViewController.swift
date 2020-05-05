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

    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        restaurantData()
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
                        
                        //let UI = UIFont()
                        
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
                    print(data)
                
                    
                    let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                    
                    let timeq = json?["queue_time"] as? [[String:Any]]
                    var item = timeq?[0]["description"] as? Int
                    
                    
                    print("data: \(data) string:\(string)")
                    DispatchQueue.main.async {
                    
                            switch indexx {
                            //witch self.index(ofAccessibilityElement: AnyIndex.self) {
                            case 0 : print("timeq1")
                            /*var value = Float(item ?? Int(0.1))
                            Favourites1.setProgress(progress: CGFloat(value), animated: true)*/
                            
                            case 1 : print("timeq2")
                                
                            case 2 : print("timeq3")
                                
                            case 3 : print("timeq4")
                                
                            case 4 : print("timeq5")
                                
                            case 5 : print("timeq6")
                                
                            case 6 : print("timeq7")
                                
                            case 7 : print("timeq8")
                                
                            default : break
                            }
                    }
                }
            })
            task.resume()
            }
        }
    }
