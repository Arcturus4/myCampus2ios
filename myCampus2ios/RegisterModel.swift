//
//  RegisterModel.swift
//  myCampus2ios
//
//  Created by iosdev on 5.5.2020.
//  Copyright © 2020 iosdev. All rights reserved.
//

import Foundation

struct RegisterUser : Codable {
    let email : String?
    let name : String?
    let password : String?
    
    init(email: String, name: String, password: String){
        self.email = email
        self.name = name
        self.password = password
    }
}


