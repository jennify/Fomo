//
//  Attraction.swift
//  Fomo
//
//  Created by Christian Deonier on 2/29/16.
//  Copyright © 2016 TeamAwesome. All rights reserved.
//

import UIKit
import CoreLocation

class Attraction: NSObject {
    
    var id: Int?
    var name: String?
    var city: City?
    var reviews: [Review]?
    var types: [AttractionType]?
    var imageUrls: [String]?
    var location: CLLocation?
    var rating: Float?
    var tripEvent: TripEvent?
    
    class func generateTestInstance(city: City) -> Attraction {
        let attraction = Attraction()
        attraction.id = 1
        attraction.name = "De Young Museum"
        attraction.city = city
        attraction.reviews = [Review.generateTestInstance(attraction)]
        attraction.types = [AttractionType.generateTestInstance()]
        attraction.imageUrls = ["http://cdn.funcheap.com/wp-content/uploads/2010/11/deYoung-Museum.-Photo-courtesy-cisl.edu_2.jpg"]
        attraction.location = CLLocation(latitude: CLLocationDegrees(37.7717392), longitude: CLLocationDegrees(-122.4692552))
        attraction.rating = 4.4
        return attraction
    }
}
