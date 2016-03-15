//
// Recommendation.swift
// ============================


import UIKit


class Recommendation: NSObject {
    
    var city: City?
    var itineraryId: String?
    var attractions: [Attraction]?
    
    class func generateTestInstance() -> Recommendation {
        let itinerary = Itinerary.generateTestInstance()
        
        let recommendation = Recommendation()
        recommendation.itineraryId = itinerary.id
        recommendation.city = itinerary.city
        recommendation.attractions = itinerary.city?.attractions
        return recommendation
    }
}
