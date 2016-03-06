//
//  Cache.swift
//  Fomo
//
//  Created by Jennifer Lee on 3/4/16.
//  Copyright © 2016 TeamAwesome. All rights reserved.
//

import UIKit
var _currentUser: User?

class Cache: NSObject {
    class var currentUser: User? {
        get {
        // TODO(jlee): Build persistence in user object.
        return _currentUser
        }
        set (user) {
            _currentUser = user
        }
    }
}
