//
//  RegisterViewController.swift
//  myCampus2ios
//
//  Created by Nea Virtanen on 28.4.2020.
//  Copyright © 2020 iosdev. All rights reserved.
//
import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var registerEmailField: UITextField!
    @IBOutlet weak var registerNameField: UITextField!
    @IBOutlet weak var registerPassField: UITextField!
    @IBOutlet weak var activityInd: UIActivityIndicatorView!
    
    var logged : String = ""
    var authToken = (UIApplication.shared.delegate as! AppDelegate).token
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityInd.hidesWhenStopped = true
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerButton(_ sender: Any) {
        self.activityInd.color = .white
        self.activityInd.startAnimating()
        
        let check = fieldCheck(field1: registerEmailField, field2: registerNameField, field3: registerPassField)
        if (!check) {
            //self.showAlert(showText: "Please fill the required fields")
            print("this should print if empty field exists")
            
            showAlert(showText: "Plaese fill all fields")
            
            activityInd.stopAnimating()
            
        } else if (!registerEmailField.text!.isValidEmail && !registerPassField.text!.isValidPassword) {
            showAlert(showText: "Check your e-mail and password")
            activityInd.stopAnimating()
        } else {
            let bodyR = RegisterUser(email: registerEmailField.text!, name: registerNameField.text!, password: registerPassField.text!)
            // let r = Register(endp: "/auth/signup")
            activityInd.stopAnimating()
            do {
                let myURL = URL(string: "https://mycampus-server.karage.fi/auth/signup")
                var request = URLRequest(url: myURL!)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = try JSONEncoder().encode(bodyR)
                // print(request.description)
                
                let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
                    if let data = data {// check for http errors
                        do {
                            if let text = String(bytes: data, encoding: .utf8){
                                print(text)
                            }
                            let body = try JSONDecoder().decode(RegisterResponse.self, from: data)
                            self.showAlert(showText: "\(body.msg)")
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
    
    func fieldCheck(field1: UITextField!, field2: UITextField!, field3: UITextField!) -> Bool{
        
        var check = false
        if (registerEmailField.hasText && registerNameField.hasText && registerPassField.hasText) {
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
                let authVC = self.storyboard?.instantiateViewController(withIdentifier: "AuthScreen")
                self.present(authVC!, animated: true, completion: nil)
                
                /*DispatchQueue.main.async {
                 self.dismiss(animated: true, completion: nil)
                 }*/
                // self.performSegue(withIdentifier: "authSegue", sender: self)
            }
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBSegueAction func presentRegisterToAuth(_ coder: NSCoder) -> AuthViewController? {
        if let authVC = AuthViewController(coder: coder){
            authVC.verification = logged
            return authVC
        }
        return nil
    }
    
    
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /* override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     if segue.identifier == "authSegue" {
     let dVC = segue.destination as? AuthViewController
     dVC?.verification = "Registration successfull"
     }
     } */
    
    
    
}



