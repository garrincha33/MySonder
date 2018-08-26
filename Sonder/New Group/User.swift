//
//  User.swift
//  Sonder
//
//  Created by Richard Price on 26/08/2018.
//  Copyright © 2018 twisted echo. All rights reserved.
//

import Foundation

struct User {
    let username: String
    let profileImageUrl: String
    
    init(dictionary: [String: Any]) {
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profilePicUrl"]  as? String ?? ""
    }
}

