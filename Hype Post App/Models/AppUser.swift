//
//  AppUser.swift
//  Hype Post App
//
//  Created by C4Q on 2/1/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import FirebaseAuth

class AppUser: NSObject {
    let email: String
    var userName: String
    let uID: String
    let firstName: String
    let lastName: String?
    var imageURL: String?
    var bio: String?
    var flags: UInt = 0
    init(email: String, userName: String, uID: String, firstName: String, lastName: String?, imageURL: String?, bio: String?, flags: UInt) {
        self.email = email; self.userName = userName; self.uID = uID; self.firstName = firstName; self.lastName = lastName; self.imageURL = imageURL ?? ""; self.bio = bio; self.flags = flags
    }
}

