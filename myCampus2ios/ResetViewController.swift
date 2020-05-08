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
        
        if (rTextField.text == "" || passTextField.text == "" || confirmTextField.text == "" || tokenField.text == "") {
            showAlert(showText: "Please fill the fields.")
            
        } else if (!rTextField.text!.isValidEmail || !passTextField.text!.isValidPassword || !confirmTextField.text!.isValidPassword) {
            showAlert(showText: "Please check the email and password fields.")
        } else if (passTextField.text! != confirmTextField.text!){
            showAlert(showText: "Passwords are not matching.. Try again!")
        } else {
            let body = ResetModel(email: rTextField.text!, password: passTextField.text!, passwordConfirm: confirmTextField.text!, resetToken: tokenField.text!)
            do {
                let myURL = URL(string: "https://mycampus-server.karage.fi/auth/reset_password")
                var request = URLRequest(url: myURL!)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = try JSONEncoder().encode(body)
                // print(request.description)
                
                let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
                    if let data = data {// check for http errors
                        do {
                            if let text = String(bytes: data, encoding: .utf8){
                                self.showAlertR(showText: text)
                            }
                            let body = try JSONDecoder().decode(ResetResp.self, from: data)
                            print(body)
                        } catch {
                            self.showAlert(showText: "Unable to reset password!")
                            print("There was an error parsing data:", error)
                        }
                    }
                    if let resp = response as? HTTPURLResponse {
                        print(resp.self)
                    }
                    
                }
                task.resume()
            } catch {
                print(error.localizedDescription)
            }
            
        }
    }
    
    func showAlert(showText: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Message", message: showText, preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .cancel) { (action: UIAlertAction!) in
                print("OK button tapped")
                /*DispatchQueue.main.async {
                 self.dismiss(animated: true, completion: nil)
                 }*/
                // self.performSegue(withIdentifier: "authSegue", sender: self)
            }
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showAlertR(showText: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Message", message: showText, preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .cancel) { (action: UIAlertAction!) in
                print("OK button tapped")
                self.performSegue(withIdentifier: "resetLogin", sender: self)
                /*DispatchQueue.main.async {
                 self.dismiss(animated: true, completion: nil)
                 }*/
                // self.performSegue(withIdentifier: "authSegue", sender: self)
            }
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dVC = segue.destination as? LoginViewController
        dVC?.log = "Password reset successful"
        
    }
    
    
}
