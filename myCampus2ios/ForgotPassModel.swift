//
//  ForgotPassModel.swift
//  myCampus2ios
//
//  Created by iosdev on 5.5.2020.
//  Copyright © 2020 iosdev. All rights reserved.
//

import Foundation

struct forgotPassModel: Codable {
    let email: String
    
    init(email: String) {
        self.email = email
    }
}
