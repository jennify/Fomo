//
// User.swift
// ============================


import UIKit


class User: NSObject {

    enum Response: Int {
        case Accepted = 0, Declined, Maybe, Invited
    }

    var id: String?
    var name: String?
    var email: String?
    var profileImageURL: String?
    var preferences: [AttractionType]?
    var response: Response?
    var rawData: NSDictionary!

    init(dictionary: NSDictionary) {
        super.init()
        self.id = dictionary["id"] as? String
        self.name = dictionary["name"] as? String
        self.email = dictionary["email"] as? String
        let pic = dictionary["picture"] as? NSDictionary
        let picData = pic?["data"] as? NSDictionary
        self.profileImageURL = picData?["url"] as? String
        self.rawData = dictionary
    }
    
    class func userFromBackend(dictionary: NSDictionary) -> User {
        let u = User(dictionary: NSDictionary())
        u.name = dictionary["name"] as? String
        u.email = dictionary["email"] as? String
        u.profileImageURL = dictionary["profileImageUrl"] as? String
        return u
    }
    
    class func usersWithArrayFromBackend(array: [NSDictionary]) -> [User] {
        var users = [User]()
        
        for dictionary in array {
            users.append(User.userFromBackend(dictionary))
        }
        return users
    }

    class func usersWithArray(array: [NSDictionary]) -> [User] {
        var users = [User]()

        for dictionary in array {
            users.append(User(dictionary: dictionary))
        }
        return users
    }
    
    class func createArray(users: [User]) -> [NSDictionary] {
        var dicts = [NSDictionary]()
        for u in users {
            dicts.append(u.rawData)
        }
        return dicts
    }
    
    func addToItinerary(itinerary: Itinerary, completion: (response: Itinerary?, error: NSError?) -> ()) {
        RecommenderClient.sharedInstance.update_itinerary_with_user(itinerary, user: self, completion: completion)
    }

    class func generateTestInstance() -> User {
        let user = User(dictionary: NSDictionary())
        user.id = "1"
        user.name = "Grumpy Cat"
        user.email = "grumpy@gmail.com"
        user.profileImageURL = "https://pbs.twimg.com/profile_images/616542814319415296/McCTpH_E.jpg"
        user.preferences = [AttractionType.generateTestInstance()]
        user.response = .Accepted
        return user
    }
}
