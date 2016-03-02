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
    
}
