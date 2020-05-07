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
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
   
    
    var accessToken = (UIApplication.shared.delegate as! AppDelegate).token
    var log : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true
        
    }
    
    
    @IBAction func LoginBtn(_ sender: Any) {
        self.activityIndicator.color = .white
        self.activityIndicator.startAnimating()
        let body = User(email: loginEmailText.text!, password: loginPassText.text!)
        let post = APIClient(endp: "/auth/login")
        
        if (loginEmailText.text == "" || loginPassText.text == "" ) {
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            self.activityIndicator.stopAnimating()
            
        } else if (!loginEmailText.text!.isValidEmail || !loginPassText.text!.isValidPassword) {
            let alertController = UIAlertController(title: "Error", message: "Please check your email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            self.activityIndicator.stopAnimating()
        }
        else {
            post.networkRequest(body, completion: {result in
                switch result {
                case .success(let body):
                    DispatchQueue.main.async {
                        print(self.accessToken ?? "")
                    }

                    print("Login successful")
                    self.activityIndicator.stopAnimating()
                    print(body.email ?? "")
                case .failure(let error):
                    let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                    self.activityIndicator.stopAnimating()
                }
            })
            
        }
        
        
    }
    
    @IBSegueAction func presentLoginToTabBar(_ coder: NSCoder) -> TabBarController? {
           return TabBarController(coder: coder)
       }
    
    
    
    
   /* override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginSegue" {
            let destVC = segue.destination as? ParkingViewController
            destVC?.loggedIn = "Logged in"
        }
    }*/
    
}

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
