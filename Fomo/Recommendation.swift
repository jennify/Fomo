//
//  Recommendation.swift
//  Fomo
//
//  Created by Christian Deonier on 2/29/16.
//  Copyright © 2016 TeamAwesome. All rights reserved.
//

import UIKit

class Recommendation: NSObject {
    
    var city: City?
    var itineraryId: Int?
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
