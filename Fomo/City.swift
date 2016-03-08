//
//  City.swift
//  Fomo
//
//  Created by Christian Deonier on 2/29/16.
//  Copyright © 2016 TeamAwesome. All rights reserved.
//

import UIKit
import CoreLocation

class City: NSObject {
    
    var id: Int?
    var name: String?
    var location: CLLocation?
    var radius: Int? // Meters
    var attractions: [Attraction]?

    
    class func generateTestInstance() -> City {
        let city = City()
        city.id = 1
        city.name = "San Francisco"
        city.location = CLLocation(latitude: 37.7833, longitude: 122.4167)
        city.radius = 200
        city.attractions = [Attraction.generateTestInstance(city)]
        return city
    }
    
}
