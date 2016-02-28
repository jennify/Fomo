//
//  User.swift
//  Fomo
//
//  Created by Jennifer Lee on 2/28/16.
//  Copyright © 2016 TeamAwesome. All rights reserved.
//

import UIKit
var _currentUser: User?

class User: NSObject {
    class var currentUser: User? {
        get {
            // TODO(jlee): Build persistence in user object.
            return _currentUser
        }
        set (user) {
            _currentUser = user
        }
    }
    
    init(dictionary: NSDictionary) {
    }
}
