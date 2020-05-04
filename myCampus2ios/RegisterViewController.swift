//
//  RegisterViewController.swift
//  myCampus2ios
//
//  Created by Nea Virtanen on 28.4.2020.
//  Copyright © 2020 iosdev. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var registerField: UITextField!
    @IBOutlet weak var registerNameField: UITextField!
    @IBOutlet weak var registerPassField: UITextField!
    
    var authToken = (UIApplication.shared.delegate as! AppDelegate).token
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func registerButton(_ sender: Any) {
        let registerBody = User(email: registerField.text!, name: registerNameField.text!, password: registerPassField.text!)
        let register = APIClient(endp: "/auth/signup")
        
        
        register.networkRequest(registerBody, completion: {result in
                  switch result {
                  case .success(let body):
                      DispatchQueue.main.async {
                          print(self.authToken)
                      }
                      print("Email is: \(String(describing: body.email))")
                      print("Password is: \(String(describing: body.password))")
                  case .failure(let error):
                      print("There was some kind of an error: \(error)")
                  }
              })
    }
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
