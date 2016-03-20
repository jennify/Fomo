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
    var address: String?
    var attractionType: [String]?
    var photoRefrences: [String] = []

    
    init(dictionary: NSDictionary) {
        if dictionary.count == 0 {
            return
        }
        self.address = dictionary["formatted_address"] as? String
        
        // Parsing location:
        let geo = dictionary["geometry"] as? NSDictionary
        let loc = geo!["location"] as? NSDictionary
        let lat = loc!["lat"] as? Double
        let long = loc!["lng"]  as? Double
        self.location = CLLocation(latitude: lat!, longitude: long!)
        
        self.name = dictionary["name"] as? String
        self.rating = dictionary["rating"] as? Float
        self.attractionType = dictionary["types"] as? [String]
        self.types = AttractionType.attractionTypesWithArray(self.attractionType!)
        
        // Temporary holder for images before they work
        self.imageUrls = ["http://cdn.funcheap.com/wp-content/uploads/2010/11/deYoung-Museum.-Photo-courtesy-cisl.edu_2.jpg"]
        self.rawData = dictionary
    }
    
    func addPhotos(photos: [String]) {
        self.imageUrls = photos
    }
    
    func getTypeString() -> String {
        var typesArr: [String] = []
        if self.types != nil {
            for type in self.types! {
                let typeNameArr = type.name!.componentsSeparatedByString("_")
                typesArr.append(typeNameArr.joinWithSeparator(" "))
            }
        }
        
        return typesArr.joinWithSeparator(", ")
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
        attraction.imageUrls = ["http://cdn.funcheap.com/wp-content/uploads/2010/11/deYoung-Museum.-Photo-courtesy-cisl.edu_2.jpg", "http://cdn.c.photoshelter.com/img-get/I0000keWPlpvpjQU/s/750/san-francisco-golden-gate-park-de-young-museum-california108519.jpg"]
        attraction.location = CLLocation(latitude: CLLocationDegrees(37.7717392), longitude: CLLocationDegrees(-122.4692552))
        attraction.rating = 4.4
        return attraction
    }
}
