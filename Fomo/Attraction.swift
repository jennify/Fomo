//
// Attraction.swift
// ============================


import UIKit
import CoreLocation


class Attraction: NSObject {
    
    var id: String?
    var name: String?
    var city: City?
    var reviews: [Review]?
    var types: [AttractionType]?
    var imageUrls: [String]?
    var location: CLLocation?
    var rating: Float?
    var tripEvent: TripEvent?
    var rawData: NSDictionary!
    
    init(dictionary: NSDictionary) {
        self.rawData = dictionary
    }
    
    func vote(vote: Vote, completion: (response: Itinerary?, error: NSError?) -> ()) {
        let itinerary = tripEvent?.itinerary
        let currentUser = Cache.currentUser
        
        RecommenderClient.sharedInstance.update_itinerary_with_vote(itinerary!, attraction: self, user: currentUser!, vote: vote, completion: completion)
    }
    
    class func generateTestInstance(city: City) -> Attraction {
        let attraction = Attraction(dictionary: NSDictionary())
        attraction.name = "De Young Museum"
        attraction.id = "trololol"
        attraction.city = city
        attraction.reviews = [Review.generateTestInstance(attraction)]
        attraction.types = [AttractionType.generateTestInstance()]
        attraction.imageUrls = ["http://cdn.funcheap.com/wp-content/uploads/2010/11/deYoung-Museum.-Photo-courtesy-cisl.edu_2.jpg"]
        attraction.location = CLLocation(latitude: CLLocationDegrees(37.7717392), longitude: CLLocationDegrees(-122.4692552))
        attraction.rating = 4.4
        return attraction
    }
}
