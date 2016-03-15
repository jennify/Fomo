//
// Recommendation.swift
// ============================


import UIKit


class Recommendation: NSObject {
    
    var city: City?
    var itineraryId: String?
    var attractions: [Attraction]?
    var rawData : NSDictionary?
    
    init(dictionary: NSDictionary) {
        if dictionary.count == 0 {
            return
        }
        
        rawData = dictionary
    }
    class func generateTestInstance() -> Recommendation {
        let itinerary = Itinerary.generateTestInstance()
        
        let recommendation = Recommendation(dictionary: NSDictionary())
        recommendation.itineraryId = itinerary.id
        recommendation.city = itinerary.city
        recommendation.attractions = itinerary.city?.attractions
        return recommendation
    }
}
