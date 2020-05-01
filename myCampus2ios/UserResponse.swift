//
//  UserResponse.swift
//  myCampus2ios
//
//  Created by iosdev on 1.5.2020.
//  Copyright © 2020 iosdev. All rights reserved.
//

import Foundation

struct UserResponse : Codable {
    let token : String?
    let exp : Int?
    let username : String?
    let email : String?
    let roles : Array<String>
}
