//
//  City.swift
//  Fomo
//
//  Created by Christian Deonier on 2/29/16.
//  Copyright © 2016 TeamAwesome. All rights reserved.
//

import UIKit

class City: NSObject {
    
    var id: Int?
    var name: String?
    var attractions: [Attraction]?
    
    class func generateTestInstance() -> City {
        let city = City()
        city.id = 1
        city.name = "San Francisco"
        city.attractions = [Attraction.generateTestInstance(city)]
        return city
    }
    
}
