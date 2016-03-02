//
//  Trip.swift
//  Fomo
//
//  Created by Christian Deonier on 2/29/16.
//  Copyright © 2016 TeamAwesome. All rights reserved.
//

import UIKit

class Itinerary: NSObject {
    
    var id: Int?
    var creator: User?
    var travellers: [User]?
    var tripName: String?
    var startDate: [NSDate]?
    var endDate: [NSDate]?
    var city: City?
    var coverPhotoUrl: String?
    var days: [Day]?
    
}
