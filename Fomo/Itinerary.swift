//
//  Trip.swift
//  Fomo
//
//  Created by Christian Deonier on 2/29/16.
//  Copyright © 2016 TeamAwesome. All rights reserved.
//

import UIKit

class Itinerary: NSObject {
    
    var id: String?
    var creator: User?
    var travellers: [User]? 
    var tripName: String?
    var startDate: NSDate?
    var endDate: NSDate?
    var city: City?
    var coverPhotoUrl: String?
    var days: [Day]?
    var rawData: NSDictionary?
    
    init(dictionary: NSDictionary) {
        if dictionary.count == 0 {
            return
        }
        self.id = dictionary["groupID"] as? String
        self.travellers = User.usersWithArray(dictionary["travellers"] as! [NSDictionary])
        print(dictionary["itinerary"])
        self.tripName = dictionary["tripName"] as? String
        self.rawData = dictionary
    }
    
    class func itinerariesWithArray(array: [NSDictionary]) -> [Itinerary] {
        var its = [Itinerary]()
        
        for dictionary in array {
            its.append(Itinerary(dictionary: dictionary))
        }
        
        return its
    }

    
    func numberDays() -> Int {
        return (days?.count)!
    }
    
    class func generateTestInstance() -> Itinerary {
        let itinerary = Itinerary(dictionary: NSDictionary())
        itinerary.id = User.generateTestInstance().email ?? "" + ":FakeItineraryID"
        itinerary.creator = User.generateTestInstance()
        itinerary.travellers = [User.generateTestInstance(), User.generateTestInstance()]
        itinerary.tripName = "San Francisco 2016"

        let today = NSDate()
        let tomorrow = NSCalendar.currentCalendar().dateByAddingUnit(
            .Day,
            value: 1,
            toDate: today,
            options: NSCalendarOptions(rawValue: 0))
        
        itinerary.startDate = today
        itinerary.endDate = tomorrow
        itinerary.city = City.generateTestInstance()
        itinerary.coverPhotoUrl = "https://upload.wikimedia.org/wikipedia/commons/0/0c/GoldenGateBridge-001.jpg"
        itinerary.days = [Day.generateTestInstance(itinerary.city!), Day.generateTestInstance(itinerary.city!), Day.generateTestInstance(itinerary.city!)]
        
        return itinerary
    }
    
}
