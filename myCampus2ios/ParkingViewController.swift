//
//  ParkingViewController.swift
//  myCampus2ios
//
//  Created by Nea Virtanen on 28.4.2020.
//  Copyright © 2020 iosdev. All rights reserved.
//

import UIKit
import MBCircularProgressBar

class ParkingViewController: UIViewController, TokenDelegate {
    var P5Progress = 0
    var p10TopProgress = 0
    var P10InsideProgress = 0
    var ElectricProgress = 0
    
func setToken(token: String) {
    print("SetToken")
    parkingData()
}
    @IBOutlet weak var ParkingStackView: UIStackView!
    
    @IBOutlet weak var ParkingP5: UIView!
    @IBOutlet weak var ParkinP5Progress: MBCircularProgressBarView!
    
    @IBOutlet weak var ParkingP10Top: UIView!
    @IBOutlet weak var ParkingP10TopProgress: MBCircularProgressBarView!
    
    @IBOutlet weak var ParkingP10Inside: UIView!
    @IBOutlet weak var ParkingP10InsideProgress: MBCircularProgressBarView!
    
    @IBOutlet weak var ParkingElectric: UIView!
    @IBOutlet weak var ParkingElectricProgress: MBCircularProgressBarView!
    
    var loggedIn : String = ""
    
    //Progress Values
    
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(loggedIn)
        (UIApplication.shared.delegate as! AppDelegate).tokenDelegate = self
        
        //Initialize Animations
        self.ParkinP5Progress.value = 0
        self.ParkingP10TopProgress.value = 0
        self.ParkingP10InsideProgress.value = 0
        self.ParkingElectricProgress.value = 0
        
        ParkingP5.layer.cornerRadius = 10
        ParkingP5.layer.masksToBounds = true
        
        ParkingP10Top.layer.cornerRadius = 10
        ParkingP10Top.layer.masksToBounds = true
        
        ParkingP10Inside.layer.cornerRadius = 10
        ParkingP10Inside.layer.masksToBounds = true
        
        ParkingElectric.layer.cornerRadius = 10
        ParkingElectric.layer.masksToBounds = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //Animate Progresses
        UIView.animate(withDuration: 2) {
            self.ParkinP5Progress.value = CGFloat(self.P5Progress)
            self.ParkingP10TopProgress.value = CGFloat(self.p10TopProgress)
            self.ParkingP10InsideProgress.value = CGFloat(self.P10InsideProgress)
            self.ParkingElectricProgress.value = CGFloat(self.ElectricProgress)
        }
    }
     let first = URL(staticString: "https://mycampus-server.karage.fi/api/common/parking/status/P5")
        let second = URL(staticString: "https://mycampus-server.karage.fi/api/common/parking/status/P10")
        let third = URL(staticString: "https://mycampus-server.karage.fi/api/common/parking/status/P10TOP")
        
        func parkingData(){
            print("parking1")
            let delegate = (UIApplication.shared.delegate as! AppDelegate)
            let token = delegate.token
            
            let urls : [URL] = [first, second, third]
            
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
                    print(data, "datacheck")
                    
                
                    //!xyMycampus2020
                     /*if let text = String(bytes: data, encoding: .utf8){
                         print(text)
                         }*/
                    var item = 0
                    let jsons = try? JSONSerialization.jsonObject(with: data, options: [])
                    
                    /* if let dictionary = jsons as? [String: Any] {
                        print("I'm here")
                    if let value = dictionary["queue_time"] as? Int {*/
                    
                    if let dictionary = jsons as? [String: Any] {
                    if let value = dictionary["percent"] as? Int {
                        do{
                            item = value
                        }
                        }
                    }
                    
                
                     
                   /* let json = try? (JSONSerialization.jsonObject(with: data, options: []) as! [String:Any])
                     let percent = json?["percent"] as? [[String:Any]]
                    print(percent as Any, " percentcheck")
                     let item = percent?[0]["description"] as? Int
                    print(item as Any, " itemcheck")*/
                     
                    
                    /*let json = try? JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                    
                    let percent = json?["percent"] as? [[String:Any]]
                    print(percent, " percentcheck")
                    let item = percent?[0]["description"] as? Int
                    print(item, " itemcheck")
                    */
                    print("data: \(data) string:\(string)")
                    DispatchQueue.main.async {
                        //Populate UI
                        
                        /*if (index == 0){
                            self.P5Progress = item ?? 0
                        }
                        else if (index == 1){
                            self.P10InsideProgress = item ?? 0
                        }
                        else if (index == 2){
                            self.p10TopProgress = (item ?? 0)/2
                            
                            self.ElectricProgress = (item ?? 0)/2
                        }*/
                        
                        switch indexx {
                        //witch self.index(ofAccessibilityElement: AnyIndex.self) {
                        case 0 : print("parking url1")
                        self.P5Progress = item
                        self.ParkinP5Progress.value = CGFloat(item)
                        print(self.P5Progress, "check")
                         
                        case 1 : print("parking url2")
                        self.P10InsideProgress = item
                        self.ParkingP10InsideProgress.value = CGFloat(item)
                        print(self.P10InsideProgress as Any, "check")
                            
                        case 2 : print("parking url3")
                        self.p10TopProgress = (item)/2
                        self.ParkingP10TopProgress.value = CGFloat(item)/2
                        print(self.p10TopProgress, "check")
                            
                        self.ElectricProgress = (item)/2
                        self.ParkingElectricProgress.value = CGFloat(item)/2
                            print(self.ElectricProgress, "check")
                            
                            
                        default:
                            break
                        
                        }
                        
                        
                        
                    }
                }
                
            })
            task.resume()
            }
        }
        
        
    }

    extension URL {
        init(staticString string: StaticString) {
            guard let url = URL(string: "\(string)") else {
                preconditionFailure("Invalid static URL string: \(string)")
            }

            self = url
        }
    }

    protocol TokenDelegate {
        func setToken(token: String)
        
        
    }
