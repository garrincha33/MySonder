//
//  Post.swift
//  Sonder
//
//  Created by Richard Price on 25/08/2018.
//  Copyright © 2018 twisted echo. All rights reserved.
//

import Foundation

struct Post {
    let user: User
    let caption: String
    
    init(user: User, dictionary: [String: Any]) {
        self.user = user
        self.caption = dictionary["caption"] as? String ?? ""
    }
}
