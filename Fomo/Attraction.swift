//
// Attraction.swift
// ============================


import UIKit
import CoreLocation


class Attraction: NSObject {
    
    var id: String?
    var name: String?
    var city: City?
    var types: [AttractionType]?
    var imageUrls: [String] {
        get {
            if self.name == "Eiffel Tower" {
                _imageUrls = [
                    "http://cdn.history.com/sites/2/2015/04/hith-eiffel-tower-iStock_000016468972Large.jpg",
                    "http://hbu.h-cdn.co/assets/15/41/768x514/gallery-1444338501-eiffel-tower-at-night.jpg",
                    "https://upload.wikimedia.org/wikipedia/commons/6/62/TourEiffel_BleuBlancRouge_(pixinn.net).jpg"
                ]
                return _imageUrls
            } else {
                return _imageUrls
            }
        }
        set (imageUrls) {
            _imageUrls = imageUrls
        }
    }
    var location: CLLocation?
    var rating: Float?
    var tripEvent: TripEvent?
    var rawData: NSDictionary!
    var address: String?
    var attractionType: [String]?
    var photoRefrences: [String] = []
    
    var _imageUrls: [String] = []
    
    var googleMapsUrl: String?
    var icon: String?
    var reviews: [Review]?
    var vicinity: String?
    var phoneNumber: String?
    var hours: [NSDictionary]?
    var hoursText: [String]?
    var numReviews: Int?
    var website: String?

    
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
        self.id = dictionary["place_id"] as? String
        
        googleMapsUrl = dictionary["url"] as? String
        icon = dictionary["icon"] as? String
        vicinity = dictionary["vicinity"] as? String
        phoneNumber = dictionary["formatted_phone_number"] as? String
        let hours_raw = dictionary["opening_hours"] as? NSDictionary
        if hours_raw != nil {
            let periodsList = hours_raw!["periods"] as? [NSDictionary]
            let periodsText = hours_raw!["weekday_text"] as? [String]
            hours = periodsList
            hoursText = periodsText
        }
        
        numReviews = dictionary["user_ratings_total"] as? Int
        website = dictionary["website"] as? String
        
        if dictionary["reviews"] != nil {
            reviews = Review.reviewsWithArray(dictionary["reviews"] as! [NSDictionary])
        } else {
            reviews = []
        }
        self.rawData = dictionary
    }
    
    class func attractionsWithArray(array: [NSDictionary]) -> [Attraction] {
        var atts = [Attraction]()
        
        for dict in array {
            let a = Attraction(dictionary: dict["rawData"] as! NSDictionary)
            a.addPhotos(dict["photos"] as! [String])
            atts.append(a)
            
        }
        
        return atts
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
    
    func vote(vote: Vote, completion: ((response: Itinerary?, error: NSError?) -> ())?) {
        let itinerary = Cache.itinerary
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
    
    class func generateTestInstances() -> [Attraction] {
        var attractions: [Attraction] = []
        
        var attraction = Attraction(dictionary: NSDictionary())
        attraction.name = "Louvre"
        attraction.id = "louvre"
        attraction.city = City.paris()
        attraction.reviews = [Review.generateTestInstance(attraction)]
        attraction.types = [AttractionType(categoryName: "Culture", categoryIcon: "culture", categoryColor: UIColor.culture())]
        attraction.imageUrls = ["https://images5.alphacoders.com/594/594362.jpg"]
        attraction.location = CLLocation(latitude: CLLocationDegrees(48.8608228), longitude: CLLocationDegrees(2.3331693))
        attraction.rating = 4.4
        attractions.append(attraction)
        
        attraction = Attraction(dictionary: NSDictionary())
        attraction.name = "Eiffel Tower"
        attraction.id = "eiffel"
        attraction.city = City.paris()
        attraction.reviews = [Review.generateTestInstance(attraction)]
        attraction.types = [AttractionType(categoryName: "Landmarks", categoryIcon: "landmarks", categoryColor: UIColor.landmarks())]
        attraction.imageUrls = ["http://hbu.h-cdn.co/assets/15/41/768x514/gallery-1444338501-eiffel-tower-at-night.jpg"]
        attraction.location = CLLocation(latitude: CLLocationDegrees(48.8582606), longitude: CLLocationDegrees(2.2945071))
        attraction.rating = 4.9
        attractions.append(attraction)
        
        return attractions
    }
    
    func parisHotels() -> [Attraction] {
        var hotels: [Attraction] = []
        
        var hotel = Attraction(dictionary: NSDictionary())
        hotel.name = "Saint James Paris - Relais et Chateaux"
        hotel.id = "hotel1"
        hotel.city = City.paris()
        hotel.reviews = []
        hotel.types = [AttractionType.hotel()]
        hotel.imageUrls = ["https://media-cdn.tripadvisor.com/media/photo-o/08/45/4c/f2/saint-james-paris-relais.jpg"]
        hotel.location = CLLocation(latitude: CLLocationDegrees(48.8710015), longitude: CLLocationDegrees(2.2792844))
        hotel.rating = 4.4
        hotels.append(hotel)
        
        hotel = Attraction(dictionary: NSDictionary())
        hotel.name = "Hotel Signature St Germain des Pres"
        hotel.id = "hotel2"
        hotel.city = City.paris()
        hotel.reviews = []
        hotel.types = [AttractionType.hotel()]
        hotel.imageUrls = ["https://media-cdn.tripadvisor.com/media/oyster/1070/07/12/f6/ef/front-desk--v3782106.jpg"]
        hotel.location = CLLocation(latitude: CLLocationDegrees(48.852225), longitude: CLLocationDegrees(2.326026))
        hotel.rating = 4.9
        hotels.append(hotel)
        
        hotel = Attraction(dictionary: NSDictionary())
        hotel.name = "Le 123 Sebastopol - Astotel"
        hotel.id = "hotel3"
        hotel.city = City.paris()
        hotel.reviews = []
        hotel.types = [AttractionType.hotel()]
        hotel.imageUrls = ["https://media-cdn.tripadvisor.com/media/oyster/1070/07/12/df/ef/deluxe-room-daniele-thompson--v42.jpg"]
        hotel.location = CLLocation(latitude: CLLocationDegrees(48.867585), longitude: CLLocationDegrees(2.353178))
        hotel.rating = 4.9
        hotels.append(hotel)
        
        hotel = Attraction(dictionary: NSDictionary())
        hotel.name = "Hotel Da Vinci"
        hotel.id = "hotel4"
        hotel.city = City.paris()
        hotel.reviews = []
        hotel.types = [AttractionType.hotel()]
        hotel.imageUrls = ["https://media-cdn.tripadvisor.com/media/photo-w/07/3e/f6/85/hotel-da-vinci.jpg"]
        hotel.location = CLLocation(latitude: CLLocationDegrees(48.856617), longitude: CLLocationDegrees(2.331923))
        hotel.rating = 4.9
        hotels.append(hotel)
        
        hotel = Attraction(dictionary: NSDictionary())
        hotel.name = "Four Seasons Hotel George V Paris"
        hotel.id = "hotel5"
        hotel.city = City.paris()
        hotel.reviews = []
        hotel.types = [AttractionType.hotel()]
        hotel.imageUrls = ["https://media-cdn.tripadvisor.com/media/photo-w/07/33/a0/fd/four-seasons-hotel-george.jpg"]
        hotel.location = CLLocation(latitude: CLLocationDegrees(48.852225), longitude: CLLocationDegrees(2.326026))
        hotel.rating = 4.9
        hotels.append(hotel)
        
        hotel = Attraction(dictionary: NSDictionary())
        hotel.name = "Hotel Eiffel Seine"
        hotel.id = "hotel6"
        hotel.city = City.paris()
        hotel.reviews = []
        hotel.types = [AttractionType.hotel()]
        hotel.imageUrls = ["https://media-cdn.tripadvisor.com/media/oyster/1070/08/f5/3a/4e/lobby-bar--v8810640.jpg"]
        hotel.location = CLLocation(latitude: CLLocationDegrees(48.854326), longitude: CLLocationDegrees(2.289179))
        hotel.rating = 4.9
        hotels.append(hotel)
        
        return hotels
    }
}
