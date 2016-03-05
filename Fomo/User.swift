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
    
    enum Response: Int {
        case Accepted = 0, Declined, Maybe, Invited
    }
    
    var id: Int?
    var name: String?
    var email: String?
    var avatarImageUrl: String?
    var preferences: [AttractionType]?
    var response: Response?
    
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
    
    class func generateTestInstance() -> User {
        let user = User(dictionary: NSDictionary())
        user.id = 1
        user.name = "Mr Bean"
        user.email = "mr.bean@gmail.com"
        user.avatarImageUrl = "http://vignette2.wikia.nocookie.net/mrbean/images/4/4b/Mr_beans_holiday_ver2.jpg/revision/latest?cb=20100424114324"
        user.preferences = [AttractionType.generateTestInstance()]
        user.response = .Accepted
        return user
    }
}
