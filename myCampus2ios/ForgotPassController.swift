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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func forgotButton(_ sender: Any) {
        let body = forgotPassModel(email: forgotEmailField.text!)
        let f = ForgotPass(endp: "/auth/forgot_password")
        
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
            f.forgotP(body, completion: {result in
                switch result {
                case .success(let reg):
                    let alertController = UIAlertController(title: "Message", message: reg.msg, preferredStyle: .alert)
                    
                    let action = UIAlertAction(title: "OK", style: .cancel, handler: { (acc) -> Void in
                        self.performSegue(withIdentifier: "resetPassSegue", sender: self)
                    })
                    alertController.addAction(action)
                    self.present(alertController, animated: true, completion: nil)
                    
                case .failure(let err):
                    let alertController = UIAlertController(title: "Error", message: err.localizedDescription , preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                }
            })
            
        }
    }
    
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "resetPassSegue" {
            let dVC = segue.destination as? ResetViewController
            dVC?.passMessage = "Got to reset password"
        }
    }
    
}
