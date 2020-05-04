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
    @IBOutlet weak var validText: UILabel!
    @IBOutlet weak var loginButton: UIButton!
   
    var accessToken = (UIApplication.shared.delegate as! AppDelegate).token
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        validText.isHidden = true
        validText.isHighlighted = false
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func LoginBtn(_ sender: Any) {
        
        let body = User(email: loginEmailText.text!, name: "", password: loginPassText.text!)
        let post = APIClient(endp: "/auth/login")
        
        if (loginEmailText.text!.isValidEmail && loginPassText.text!.isValidPassword) {
            validText.isHighlighted = true
            self.loginButton.isEnabled = true
            validText.text = "Email is valid"
        }
        else {
            validText.isHighlighted = true
            self.loginButton.isEnabled = false
            validText.text = "Email is not valid"
        }
        
        post.networkRequest(body, completion: {result in
            switch result {
            case .success(let body):
                DispatchQueue.main.async {
                    print(self.accessToken)
                }
                print("Email is: \(String(describing: body.email))")
                print("Password is: \(String(describing: body.password))")
            case .failure(let error):
                print("There was some kind of an error: \(error)")
            }
        })
        
    }
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
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
