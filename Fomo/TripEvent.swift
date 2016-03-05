//
//  TripEvent.swift
//  Fomo
//
//  Created by Christian Deonier on 2/29/16.
//  Copyright © 2016 TeamAwesome. All rights reserved.
//

import UIKit

class TripEvent: NSObject {
    
    enum Vote: Int {
        case Dislike = 1, Neutral, Like
    }
    
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
    
    class func generateTestInstance(city: City) -> TripEvent {
        let tripEvent = TripEvent()
        tripEvent.id = 1
        tripEvent.attraction = Attraction.generateTestInstance(city)
        tripEvent.eventType = .Morning
        tripEvent.dislikers = []
        tripEvent.likers = []
        tripEvent.dislikers = []
        return tripEvent
    }
    
}
