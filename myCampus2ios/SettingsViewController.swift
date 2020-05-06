//
//  SettingsViewController.swift
//  myCampus2ios
//
//  Created by Nea Virtanen on 28.4.2020.
//  Copyright © 2020 iosdev. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, TokenDelegate {
    func setToken(token: String) {
    }
    
    
    var tokenPayload = (UIApplication.shared.delegate as! AppDelegate).token
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func buttonLogOut(_ sender: Any) {
        tokenPayload?.removeAll()
         self.performSegue(withIdentifier: "logoutSegue", sender: self)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backtoLoginSegue" {
            let dVC = segue.destination as? LoginViewController
            dVC?.log = "Password reset successful"
        }
    }
    
    
}
