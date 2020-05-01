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
    
    @IBOutlet weak var LoginBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
                print("Email is: \(String(describing: body.email))")
                print("Password is: \(String(describing: body.password))")
            case .failure(let error):
                print("There was an error: \(error)")
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
