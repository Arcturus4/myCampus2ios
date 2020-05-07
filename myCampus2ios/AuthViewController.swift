//
//  AuthViewController.swift
//  myCampus2ios
//
//  Created by iosdev on 5.5.2020.
//  Copyright © 2020 iosdev. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    
    @IBOutlet weak var verificationEmail: UITextField!
    @IBOutlet weak var verificationToken: UITextField!
    
    var verification : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func verifyButton(_ sender: Any) {
        let check = fieldCheck(field1: verificationEmail, field2: verificationToken)
        if (!check) {
            //self.showAlert(showText: "Please fill the required fields")
            print("this should print if empty field exists")
            
            showAlert(showText: "Plaese fill all the fields")
            
        } else if (!verificationEmail.text!.isValidEmail) {
            showAlert(showText: "Check your e-mail")
        } else {
            let authBody = AuthModel(email: verificationEmail.text!, token: verificationToken.text!)
            do {
                let myURL = URL(string: "https://mycampus-server.karage.fi/auth/confirmation")
                var request = URLRequest(url: myURL!)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = try JSONEncoder().encode(authBody)
                // print(request.description)
                
                let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
                    if let data = data {// check for http errors
                        do {
                            if let text = String(bytes: data, encoding: .utf8){
                                print(text)
                            }
                            let body = try JSONDecoder().decode(UserResponse.self, from: data)
                            self.showAlert(showText: "You have registered successfully: \(body.username)")
                        } catch {
                            print("There was an error parsing data:", error)
                            self.showAlert(showText: "Something failed.. Try again!")
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
    
    func fieldCheck(field1: UITextField!, field2: UITextField!) -> Bool{
        
        var check = false
        if (verificationEmail.hasText && verificationToken.hasText) {
            check = true
            return check
        } else{
            return check
        }
    }
    
    func showAlert(showText: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Message", message: showText, preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .cancel) { (action: UIAlertAction!) in
                print("OK button tapped")
                self.performSegue(withIdentifier: "AuthToTab", sender: self)
                
                /*DispatchQueue.main.async {
                 self.dismiss(animated: true, completion: nil)
                 }*/
                // self.performSegue(withIdentifier: "authSegue", sender: self)
            }
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

/* @IBSegueAction func PresentAuthToTab(_ coder: NSCoder) -> TabBarController? {
 return TabBarController(coder: coder)
 } */



/* override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 if segue.identifier == "parkSegue" {
 let dVC = segue.destination as? AuthViewController
 dVC?.verification = "Registration successfull"
 }
 }*/

