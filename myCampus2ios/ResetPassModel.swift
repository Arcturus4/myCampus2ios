//
//  ResetPassModel.swift
//  myCampus2ios
//
//  Created by iosdev on 5.5.2020.
//  Copyright © 2020 iosdev. All rights reserved.
//

import Foundation

struct ResetModel: Codable {
    let email: String?
    let password: String?
    let passwordConfirm: String?
    let resetToken: String?
    
    init(email: String, password: String, passwordConfirm: String, resetToken: String) {
        self.email = email
        self.password = password
        self.passwordConfirm = passwordConfirm
        self.resetToken = resetToken
    }
}
