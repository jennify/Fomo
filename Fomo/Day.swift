//
// Day.swift
// ============================


import UIKit


class Day: NSObject {

    var tripEvents: [TripEvent]?
    var rawData: NSDictionary?

    init(dictionary: NSDictionary) {
        if dictionary.count == 0 {
            return
        }
        let tripEventsDicts = dictionary["tripEvents"] as? [NSDictionary]
        
        self.tripEvents = []
        if tripEventsDicts != nil {
            for trip in tripEventsDicts! {
                self.tripEvents?.append(TripEvent(dictionary: trip))
            }
        }
        
        self.rawData = dictionary
    }
    
    class func generateTestInstance(city: City) -> Day {
        let day = Day(dictionary: NSDictionary())
        day.tripEvents = [TripEvent.generateTestInstance(city), TripEvent.generateTestInstance(city), TripEvent.generateTestInstance(city)]
        return day
    }
}
