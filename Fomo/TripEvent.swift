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

    var id: Int?
    var attraction: Attraction?
    var eventType: EventType?
    var vote: Vote? // Current user's vote
    var dislikers: [User]?
    var likers: [User]?
    var neutrals: [User]?
    var rawData: NSDictionary!
    
    init(dictionary: NSDictionary) {
        if dictionary.count == 0 {
            return
        }
        print(dictionary)
        self.rawData = dictionary
    }
    
    class func generateTestInstance(city: City) -> TripEvent {
        let tripEvent = TripEvent(dictionary: NSDictionary())
        tripEvent.id = 1
        tripEvent.attraction = Attraction.generateTestInstance(city)
        tripEvent.eventType = .Morning
        tripEvent.dislikers = []
        tripEvent.likers = []
        tripEvent.neutrals = []
        return tripEvent
    }
    
}
