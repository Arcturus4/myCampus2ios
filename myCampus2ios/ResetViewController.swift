//
//  ResetViewController.swift
//  myCampus2ios
//
//  Created by Nea Virtanen on 28.4.2020.
//  Copyright © 2020 iosdev. All rights reserved.
//

import UIKit

class ResetViewController: UIViewController {

    @IBOutlet weak var rTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!
    @IBOutlet weak var tokenField: UITextField!
    
    var passMessage : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func resetButton(_ sender: Any) {
        
        let body = ResetModel(email: rTextField.text!, password: passTextField.text!, passwordConfirm: confirmTextField.text!, resetToken: tokenField.text!)
        let reset = ResetPass(endp: "/auth/reset_password")
        
        if (rTextField.text == "" || passTextField.text == "" || confirmTextField.text == "" || tokenField.text == "") {
            let alertController = UIAlertController(title: "Error", message: "Please fill the fields.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            
        } else if (!rTextField.text!.isValidEmail || !passTextField.text!.isValidPassword || !confirmTextField.text!.isValidPassword) {
            let alertController = UIAlertController(title: "Error", message: "Please check the email and password fields.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            reset.resetP(body, completion: {result in
                switch result {
                case .success(let reg):
                    let alertController = UIAlertController(title: "Message", message: reg.value, preferredStyle: .alert)
                        
                        let action = UIAlertAction(title: "OK", style: .cancel, handler: { (acc) -> Void in
                            self.performSegue(withIdentifier: "backtoLoginSegue", sender: self)
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
        if segue.identifier == "backtoLoginSegue" {
                   let dVC = segue.destination as? LoginViewController
            dVC?.log = "Password reset successful"
               }
        
    }
    

}
