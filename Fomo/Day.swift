//
// Day.swift
// ============================


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
