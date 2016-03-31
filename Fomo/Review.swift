//
// Review.swift
// ============================


import UIKit

class Review: NSObject {
    var rating: Int?
    var text: String?
    var authorName: String?
    var profilePhotoURL: String?
    var time: Int? // Unix Time
    var rawData: NSDictionary?
    
    init(dictionary: NSDictionary) {
        if dictionary.count == 0 {
            return
        }
        time = dictionary["time"] as? Int
        rating = dictionary["rating"] as? Int
        text = dictionary["text"] as? String
        authorName = dictionary["author_name"] as? String
        profilePhotoURL = dictionary["profile_photo_url"] as? String
        rawData = dictionary
    }
    
    class func reviewsWithArray(array: [NSDictionary]) -> [Review] {
        var rs = [Review]()
        
        for dict in array {
            let r = Review(dictionary: dict as! NSDictionary)
            rs.append(r)
            
        }
        return rs
    }
    
    class func generateTestInstance(attraction: Attraction) -> Review {
        let review = Review(dictionary: NSDictionary())
        review.text = "5 star review"
        review.time = 1452930121
        review.rating = 5
        return review
    }
    
}
