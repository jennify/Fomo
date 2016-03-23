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
        attractions = Attraction.attractionsWithArray(dictionary["attractions"] as! [NSDictionary])
        rawData = dictionary
    }
    
    class func generateTestInstance() -> Recommendation {
        let itinerary = Itinerary.generateTestInstance()
        
        let recommendation = Recommendation(dictionary: NSDictionary())
        recommendation.itineraryId = itinerary.id
        recommendation.city = itinerary.city
        recommendation.attractions = [
            Attraction.generateTestInstance(City.generateTestInstance()),
            Attraction.generateTestInstance(City.generateTestInstance()),
            Attraction.generateTestInstance(City.generateTestInstance()),
        ]
        return recommendation
    }
    
    class func getRecommendations(completion:(response: Recommendation?, error: NSError?) -> ()) {
        let it = Cache.itinerary
        if it == nil {
            completion(response: nil, error: NSError(domain: "No Itinerary", code: 1, userInfo: nil))
        } else {
            RecommenderClient.sharedInstance.get_recommendations_with_user(Cache.currentUser!, groupID: it!.id!, completion: completion)
        }
    }
}
