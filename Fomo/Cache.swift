//
// Cache.swift
// ============================


import UIKit
var _currentUser: User?
var _currentFriends: [User]?


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
    
    class var currentFriends: [User]? {
        get {
            return _currentFriends
        }
        set (friends) {
            _currentFriends = friends
        }
    }
    
    class func addFriendPage(friends: [User]?) {
        if friends != nil {
            if Cache.currentFriends == nil  {
                Cache.currentFriends = friends
            } else {
                Cache.currentFriends!.appendContentsOf(friends!)
            }
        }
    }
}
