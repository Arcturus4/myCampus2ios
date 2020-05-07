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
           showAlert(showText: "Please fill all fields")
            
        } else if (!verificationEmail.text!.isValidEmail) {
    showAlert(showText: "Please enter a valid e-mail")
        } else {
            a.auth(authBody, completion: {result in
                switch result {
                case .success(let reg):
                    self.showAlert(showText: "Registration successful \(String(describing: reg.token))")
                    
                    
                case .failure(let error):
                    self.showAlert(showText: "There was an unexpected error \(error.localizedDescription)")
                    
                break
                }
            })
            
        }
    }
    
    func showAlert(showText: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Message", message: showText, preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .cancel) { (action: UIAlertAction!) in
                print("OK button tapped")
                
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
                // self.performSegue(withIdentifier: "authSegue", sender: self)
            }
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
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
