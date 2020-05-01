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
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func LoginBtn(_ sender: Any) {
        
        let emailtxt = loginEmailText.text
        let passtxt = loginPassText.text
        let body = User(email: emailtxt!, password: passtxt!)
        let post = APIClient(endp: "/auth/login")
        
        post.networkRequest(body, completion: {result in
            switch result {
            case .success(let body):
               DispatchQueue.main.async {
                print(self.accessToken)
                }
                print("Email is: \(String(describing: body.email))")
                print("Password is: \(String(describing: body.password))")
            case .failure(let error):
                print("There was an error: \(error)")
            }
        })
        
        guard let emailfield = loginEmailText.text, loginEmailText.text?.count != 0
            else {
                validText.isHidden = false
                validText.text = "Please enter your e-mail.."
                return
        }
        
        if isValid(emailString: emailfield) == false {
            validText.isHidden = false
            validText.text = "Please enter valid e-mail.."
            self.loginButton.isEnabled = false
        } else {
            self.loginButton.isEnabled = true
        }
        
        guard let passwordfield = loginPassText.text, loginPassText.text?.count != 0
                   else {
                       validText.isHidden = false
                       validText.text = "Please enter your password.."
                       return
               }
        if passwordfield.isEmpty == false{
            self.loginButton.isEnabled = true
        } else {
            self.loginButton.isEnabled = false
        }
        
    }
    
    func isValid(emailString: String) -> Bool {
        let eRgx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-za-z]{2,}"
        let rgxValue = NSPredicate(format: "SELF MATCHES %@", eRgx)
        return rgxValue.evaluate(with: emailString)
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
