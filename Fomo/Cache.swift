//
// Cache.swift
// ============================


import UIKit

var _currentUser: User?
var _currentFriends: [User]?

let currentUserKey = "kCurrentUserKey"

class Cache: NSObject {
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey)
                if data != nil {
                    do {
                        let dictionary = try NSJSONSerialization.JSONObjectWithData(data as! NSData, options: [])
                        _currentUser = User(dictionary: dictionary as! NSDictionary)
                    } catch {
                        print("Error deserializing")
                    }
                }
            }
            return _currentUser
        }
        set (user) {
            _currentUser = user
            
            if _currentUser != nil {
                do {
                    let json = try NSJSONSerialization.dataWithJSONObject(user!.rawData, options: [])
                    NSUserDefaults.standardUserDefaults().setObject(json, forKey: currentUserKey)
                } catch {
                    print("Error serializing")
                }
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
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
