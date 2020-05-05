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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var logged : String = ""
    var authToken = (UIApplication.shared.delegate as! AppDelegate).token
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidesWhenStopped = true
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func registerButton(_ sender: Any) {
        self.activityIndicator.color = .white
        self.activityIndicator.startAnimating()
        
        let bodyR = RegisterUser(email: registerEmailField.text!, name: registerNameField.text!, password: registerPassField.text!)
        let r = Register(endp: "/auth/signup")
        
        if (registerEmailField.text == "" || registerPassField.text == "" || registerNameField.text == "") {
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            self.activityIndicator.stopAnimating()
            
        } else if (!registerEmailField.text!.isValidEmail || !registerPassField.text!.isValidPassword) {
            let alertController = UIAlertController(title: "Error", message: "Please check your email, name and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            self.activityIndicator.stopAnimating()
        } else {
            r.registerReq(bodyR, completion: {result in
                switch result {
                case .success(let reg):
                    // resp = UserResponse
                    DispatchQueue.main.async {
                        let alertController = UIAlertController(title: "Message", message: "E-mail verification sent to: \(String(describing: reg.email)).", preferredStyle: .alert)
                        
                        let action = UIAlertAction(title: "OK", style: .cancel, handler: { _ -> Void in
                            self.performSegue(withIdentifier: "authSegue", sender: self)
                        })
                        alertController.addAction(action)
                        self.present(alertController, animated: true, completion: nil)
                    }
                    self.activityIndicator.stopAnimating()
                    
                case .failure(let err):
                    let alertController = UIAlertController(title: "Error", message: err.localizedDescription , preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                    self.activityIndicator.stopAnimating()
                }
            })
            
        }
        
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "authSegue" {
            let dVC = segue.destination as? AuthViewController
            dVC?.verification = "Registration successfull"
        }
    }
    
    
}

