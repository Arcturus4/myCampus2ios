//
//  User.swift
//  myCampus2ios
//
//  Created by iosdev on 30.4.2020.
//  Copyright © 2020 iosdev. All rights reserved.
//

import Foundation

struct User : Codable {
    let email : String?
    let password : String?
    let name : String?
    
    init(email: String, name: String, password: String) {
        self.email = email
        self.password = password
        self.name = name
    }
}

struct RegisterUser : Codable {
    let email : String?
    let name : String?
    let password : String?
}
