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
    
    @IBSegueAction func PresentAuthToTab(_ coder: NSCoder) -> TabBarController? {
        return TabBarController(coder: coder)
    }
    var verification : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func verifyButton(_ sender: Any) {
        let authBody = AuthModel(email: verificationEmail.text!, token: verificationToken.text!)
        let a = Authenticate(endp: "/auth/confirmation")
        
        if (verificationEmail.text == "" || verificationToken.text == "") {
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and token.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            
        } else if (!verificationEmail.text!.isValidEmail) {
            let alertController = UIAlertController(title: "Error", message: "Please check your email", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            a.auth(authBody, completion: {result in
                switch result {
                case .success(let reg):
                    /* DispatchQueue.main.async {
                     print(self.authToken)
                     }*/
                    let alertController = UIAlertController(title: "Message", message: "E-mail verification sent to: \(String(describing: reg.email)).", preferredStyle: .alert)
                    
                    let action = UIAlertAction(title: "OK", style: .cancel, handler: { _ -> Void in
                        self.performSegue(withIdentifier: "parkSegue", sender: self)
                    })
                    alertController.addAction(action)
                    self.present(alertController, animated: true, completion: nil)
                    print("Login successful \(String(describing: reg.email))")
                    
                    
                case .failure(let error):
                    let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            })
            
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "parkSegue" {
            let dVC = segue.destination as? AuthViewController
            dVC?.verification = "Registration successfull"
        }
    }
    
    
}
