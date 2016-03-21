//
// Cache.swift
// ============================


import UIKit

var _currentUser: User?
var _currentFriends: [User]?
var _currentItinerary: Itinerary?

let currentUserKey = "kCurrentUserKey"
let currentItinerary = "kCurrentItinerary"
let kcurrentFriends = "kCurrentFriends"

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
            if _currentFriends == nil {
                let data = NSUserDefaults.standardUserDefaults().objectForKey(kcurrentFriends)
                if data != nil {
                    do {
                        let dictionary = try NSJSONSerialization.JSONObjectWithData(data as! NSData, options: [])
                        _currentFriends = User.usersWithArray(dictionary as! [NSDictionary])
                    } catch {
                        print("Error deserializing")
                    }
                }
            }
            return _currentFriends
        }
        set (friends) {
            _currentFriends = friends

            if _currentFriends != nil {
                do {
                    let json = try NSJSONSerialization.dataWithJSONObject(User.createArray(friends!), options: [])
                    NSUserDefaults.standardUserDefaults().setObject(json, forKey: kcurrentFriends)
                } catch {
                    print("Error serializing")
                }
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: kcurrentFriends)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
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

    class var itinerary: Itinerary? {
        get {
            if _currentItinerary == nil {
                let data = NSUserDefaults.standardUserDefaults().objectForKey(currentItinerary)
                if data != nil {
                    do {
                        let dictionary = try NSJSONSerialization.JSONObjectWithData(data as! NSData, options: [])
                        _currentItinerary = Itinerary(dictionary: dictionary as! NSDictionary)
                    } catch {
                        print("Error deserializing")
                    }
                }
            }
            return _currentItinerary
        }
        set (it) {
            _currentItinerary = it

            if _currentItinerary != nil {
                do {
                    let json = try NSJSONSerialization.dataWithJSONObject(it!.rawData, options: [])
                    NSUserDefaults.standardUserDefaults().setObject(json, forKey: currentItinerary)
                } catch {
                    print("Error serializing")
                }
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentItinerary)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
}