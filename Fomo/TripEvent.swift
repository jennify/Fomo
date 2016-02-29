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

    var id: Int?
    var attraction: Attraction?
    var startTime: NSDate?
    var endTime: NSDate?
    var vote: Vote? // Current user's vote
    var dislikers: [User]?
    var likers: [User]?
    var neutrals: [User]?
    
}
