//
//  LoginViewController.swift
//  myCampus2ios
//
//  Created by Nea Virtanen on 28.4.2020.
//  Copyright © 2020 iosdev. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginEmailText: UITextField!
    @IBOutlet weak var loginPassText: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var logB: UIButton!
    @IBOutlet weak var regB: UIButton!
    @IBOutlet weak var forgB: UIButton!
    
    
    var accessToken = (UIApplication.shared.delegate as! AppDelegate).token
    var log : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true
        
    }
    
    
    @IBAction func LoginBtn(_ sender: Any) {
        self.activityIndicator.color = .white
        self.activityIndicator.startAnimating()
        
        // Checking if the fields are empty
        if (loginEmailText.text == "" || loginPassText.text == "" ) {
           showAlert(showText: "Please enter your email and password!")
            self.activityIndicator.stopAnimating()
            // Checking if e-mail and password fields are not valid, then
            // a false alert will appear
        } else if (!loginEmailText.text!.isValidEmail || !loginPassText.text!.isValidPassword) {
          showAlert(showText: "Please enter a valid email or password")
             self.activityIndicator.stopAnimating()
        }
            // If every field contains an valid e-mail and password,
            // then a network request will be called and executed
        else {
             let body = User(email: loginEmailText.text!, password: loginPassText.text!)
                // Checking between successful response and failure from the server
                do {
                    let myURL = URL(string: "https://mycampus-server.karage.fi/auth/login")
                    var request = URLRequest(url: myURL!)
                    request.httpMethod = "POST"
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.httpBody = try JSONEncoder().encode(body)
                    
                    // Here, we are handling the data response and possible errors:
                    let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
                        if let data = data {
                            do {
                                if let text = String(bytes: data, encoding: .utf8){
                                    print(text)
                                }
                                // De
                                let body = try JSONDecoder().decode(UserResponse.self, from: data)
                                self.showAlertLogin(showText: "Welcome to myCampus \n   \(body.username)!")
                                DispatchQueue.main.async {
                                    (UIApplication.shared.delegate as! AppDelegate).user = self.loginEmailText.text!
                                    self.activityIndicator.stopAnimating()
                                    (UIApplication.shared.delegate as! AppDelegate).token = body.token
                                }
                            } catch {
                                self.showAlert(showText: "Invalid e-mail or password")
                                DispatchQueue.main.async {
                                    self.activityIndicator.stopAnimating()
                                }
                                print("There was an error parsing data:", error)
                            }
                        }
                        if let resp = response as? HTTPURLResponse {
                            print(resp.statusCode)
                        }
                        
                    }
                    // Continuing the URLSession task
                    task.resume()
                    // Handling the errors, if the request was unsuccessful
                } catch {
                    print(Error.self)
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
    
    func showAlertLogin(showText: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Message", message: showText, preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .cancel) { (action: UIAlertAction!) in
                print("OK button tapped")
                self.performSegue(withIdentifier: "logintoTab", sender: self)

                /*DispatchQueue.main.async {
                 self.dismiss(animated: true, completion: nil)
                 }*/
                // self.performSegue(withIdentifier: "authSegue", sender: self)
            }
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func registerB(_ sender: Any) {
        print("Forgot button clicked")
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "registerSegue", sender: self)
        }
    }
    
    @IBAction func forgotB(_ sender: Any) {
        print("Forgot button clicked")
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "registerSegue", sender: self)
        }
    }
    
        /* @IBSegueAction func presentLoginToTabBar(_ coder: NSCoder) -> TabBarController? {
         return TabBarController(coder: coder)
         } */
        
        
        
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if logB.isSelected {
                 let destVC = segue.destination as! ParkingViewController
                           destVC.loginT = "Logged in"
            } else if regB.isSelected {
                let regVC = segue.destination as! RegisterViewController
                regVC.logged = "Register"
            } else if forgB.isSelected {
                let forgVC = segue.destination as! ForgotPassController
                forgVC.forgotCheck = "Forgot password reached"
            }
            return
        }
        
    }
    
    // This block is an extension to add the regex validations into a String so that
    // any String variables have acceess to these properties
    
    extension String {
        var isValidEmail : Bool {
            let eRgx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-za-z]{2,}"
            let rgxEmailValue = NSPredicate(format: "SELF MATCHES %@", eRgx)
            return rgxEmailValue.evaluate(with: self)
        }
        
        var isValidPassword : Bool {
            let passRgx = "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}"
            let rgxPassValue = NSPredicate(format: "SELF MATCHES %@", passRgx)
            return rgxPassValue.evaluate(with: self)
        }
}
