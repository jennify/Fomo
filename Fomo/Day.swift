//
//  Day.swift
//  Fomo
//
//  Created by Christian Deonier on 2/29/16.
//  Copyright © 2016 TeamAwesome. All rights reserved.
//

import UIKit

class Day: NSObject {

    var id: Int?
    var tripEvents: [TripEvent]?
    
    class func generateTestInstance(city: City) -> Day {
        let day = Day()
        day.id = 1
        day.tripEvents = [TripEvent.generateTestInstance(city), TripEvent.generateTestInstance(city), TripEvent.generateTestInstance(city)]
        return day
    }
}
