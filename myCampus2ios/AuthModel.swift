//
//  AuthResponse.swift
//  myCampus2ios
//
//  Created by iosdev on 5.5.2020.
//  Copyright © 2020 iosdev. All rights reserved.
//

import Foundation

struct AuthModel : Codable {
    let email : String?
    let token : String?
}
