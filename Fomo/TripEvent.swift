//
// TripEvent.swift
// ============================


import UIKit


enum Vote: Int {
    case Dislike = 1, Neutral, Like
}

class TripEvent: NSObject {
    

    enum EventType: String {
        case
        Breakfast = "breakfast",
        Lunch = "lunch",
        Dinner = "dinner",
        Morning = "morning",
        Afternoon = "afternoon",
        Evening = "evening"
    }

    var id: String?
    var itinerary: Itinerary?
    var attraction: Attraction?
    var eventType: EventType?
    var vote: Vote? // Current user's vote
    var dislikers: [User]? = []
    var likers: [User]? = []
    var neutrals: [User]? = []
    var rawData: NSDictionary!
    
    init(dictionary: NSDictionary) {
        if dictionary.count == 0 {
            return
        }
        
        self.id = dictionary["placeID"] as? String
        
        // Parsing likes and dislikes
        let keys: [String] = ["likes", "dislikes", "neutral"]
        for k in keys {
            let users = dictionary[k] as? [NSDictionary]
            var userObjList: [User] = []
            for u in users! {
                let user_dict: NSDictionary = [
                    "name": u["name"] as! String,
                    "email": u["email"] as! String,
                    "picture": [
                        "data" : [
                            "url": u["profileImageURL"] as! String,
                        ]
                    ]
                ]
                userObjList.append(User(dictionary: user_dict))
            }
            
            if k == "likes" {
                self.likers?.appendContentsOf(userObjList)
            } else if k == "dislikes" {
                self.dislikers?.appendContentsOf(userObjList)
            } else {
                self.neutrals?.appendContentsOf(userObjList)
            }
        }
        
        self.attraction = Attraction(dictionary: dictionary["rawData"] as! NSDictionary)
        self.vote = Vote(rawValue: dictionary["vote"] as! Int)
        self.rawData = dictionary
    }
    
    class func generateTestInstance(city: City) -> TripEvent {
        let tripEvent = TripEvent(dictionary: NSDictionary())
        tripEvent.id = "1"
        tripEvent.attraction = Attraction.generateTestInstance(city)
        tripEvent.eventType = .Morning
        tripEvent.dislikers = []
        tripEvent.likers = []
        tripEvent.neutrals = []
        return tripEvent
    }
    
}
