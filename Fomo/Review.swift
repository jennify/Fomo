//
//  Review.swift
//  Fomo
//
//  Created by Christian Deonier on 2/29/16.
//  Copyright © 2016 TeamAwesome. All rights reserved.
//

import UIKit

class Review: NSObject {

    var id: Int?
    var attraction: Attraction?
    var message: String?
    var createdAt: NSDate?
    var rating: Int?

    class func generateTestInstance(attraction: Attraction) -> Review {
        let review = Review()
        review.id = 1
        review.attraction = attraction
        review.message = "Jesus Christ, it looks like a Star Destroyer!"
        review.createdAt = NSDate()
        review.rating = 5
        return review
    }

}
