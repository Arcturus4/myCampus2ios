//
//  ForgotPassController.swift
//  myCampus2ios
//
//  Created by iosdev on 5.5.2020.
//  Copyright © 2020 iosdev. All rights reserved.
//

import UIKit

class ForgotPassController: UIViewController {
    
    @IBOutlet weak var forgotEmailField: UITextField!
    
    var forgotCheck : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func forgotButton(_ sender: Any) {
        
        if (forgotEmailField.text == "") {
            let alertController = UIAlertController(title: "Error", message: "Please enter your email.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            
        } else if (!forgotEmailField.text!.isValidEmail) {
            let alertController = UIAlertController(title: "Error", message: "Please check your email address.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            let model = forgotPassModel(email: forgotEmailField.text!)
            do {
                let baseURL = URL(string: "https://mycampus-server.karage.fi/auth/forgot_password")
                var request = URLRequest(url: baseURL!)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = try JSONEncoder().encode(model)
                // print(request.description)
                
                let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
                    if let data = data {// check for http errors
                        do {
                            if let text = String(bytes: data, encoding: .utf8){
                                self.showAlertP(showText: text)
                            }
                            let body = try JSONDecoder().decode(ResetResp.self, from: data)
                              print(body)
                        } catch {
                            self.showAlert(showText: "Reset token sent already or e-mail doesn't exist")
                            print("There was an error parsing data:", error)
                        }
                    }
                    if let resp = response as? HTTPURLResponse {
                        print(resp.self)
                    }
                    
                }
                task.resume()
            } catch {
                print(error.localizedDescription)
            }
            
        }
    }
    
    func showAlert(showText: String) {
           DispatchQueue.main.async {
               let alertController = UIAlertController(title: "Message", message: showText, preferredStyle: .alert)
               
               let action = UIAlertAction(title: "OK", style: .cancel) { (action: UIAlertAction!) in
                   print("OK button tapped")
                   
                   /*DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                    }*/
                   // self.performSegue(withIdentifier: "authSegue", sender: self)
               }
               alertController.addAction(action)
               self.present(alertController, animated: true, completion: nil)
           }
       }
    
    func showAlertP(showText: String) {
            DispatchQueue.main.async {
                let alertController = UIAlertController(title: "Message", message: showText, preferredStyle: .alert)
                
                let action = UIAlertAction(title: "OK", style: .cancel) { (action: UIAlertAction!) in
                    print("OK button tapped")
                    self.performSegue(withIdentifier: "resetpassSegue", sender: self)
                    /*DispatchQueue.main.async {
                     self.dismiss(animated: true, completion: nil)
                     }*/
                    // self.performSegue(withIdentifier: "authSegue", sender: self)
                }
                alertController.addAction(action)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let dVC = segue.destination as? ResetViewController
            dVC?.passMessage = "Got to reset password"
    }
    
}
