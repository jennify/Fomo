//
// RecommenderClient.swift
// ============================


import UIKit
import BDBOAuth1Manager

let USE_LOCAL_DEV_ENVIROMENT = false

class RecommenderClient: BDBOAuth1RequestOperationManager {
    // No Auth attached!
    var recommender_domain: String {
        get {
            if USE_LOCAL_DEV_ENVIROMENT {
                return "http://127.0.0.1:8000"
            } else {
                return "https://fomorecommender.herokuapp.com"
            }
        }
    }
    
    class var sharedInstance: RecommenderClient {
        struct Static {
            static let instance = RecommenderClient()
        }
        return Static.instance
    }
    
    func requestGETWithItineraryResponse(url: String, parameters: NSDictionary, completion:(response: Itinerary?, error: NSError?) -> () ) {
        GET(url, parameters: parameters, success:  { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            let it = Itinerary(dictionary: response as! NSDictionary)
            Cache.itinerary = it
            completion(response: it, error: nil)
            
        }, failure: { (operation: AFHTTPRequestOperation?, error: NSError) -> Void in
            completion(response: nil, error: error)
        })
    }
    
    func requestGETWithItinerariesResponse(url: String, parameters: NSDictionary, completion:(response: [Itinerary]?, error: NSError?) -> () ) {
        GET(url, parameters: parameters, success:  { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            let its = Itinerary.itinerariesWithArray(response as! [NSDictionary])
            Cache.itinerary = its.first
            completion(response: its, error: nil)
        }, failure: { (operation: AFHTTPRequestOperation?, error: NSError) -> Void in
            completion(response: nil, error: error)
        })
    }
    
    func requestPOSTWithItineraryResponse(url: String, parameters: NSDictionary, completion:(response: Itinerary?, error: NSError?) -> () ) {
        POST(url, parameters: parameters, success:  { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            let it = Itinerary(dictionary: response as! NSDictionary)
            Cache.itinerary = it
            completion(response: it, error: nil)
        }, failure: { (operation: AFHTTPRequestOperation?, error: NSError) -> Void in
            completion(response: nil, error: error)
        })
    }

    func get_recommendations_with_user (user: User, groupID: String, completion: (response: Recommendation?, error: NSError?) -> ()) {
        let url = recommender_domain + "/get_recommendations/"
        let parameters = ["groupID": groupID, "userEmail": user.email!]
        GET(url, parameters: parameters, success:  { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            let rec = Recommendation(dictionary: response as! NSDictionary)
            completion(response: rec, error: nil)
        }, failure: { (operation: AFHTTPRequestOperation?, error: NSError) -> Void in
            completion(response: nil, error: error)
        })
    }
    
    func update_itinerary_with_vote (itinerary: Itinerary, attraction: Attraction, user: User, vote: Vote, completion: (response: Itinerary?, error: NSError?) -> ()) {
        let url = recommender_domain + "/update_itinerary_with_vote/"
        var parameters: [String: String] = ["groupID": itinerary.id!, "placeID": attraction.id!, "userEmail": user.email! ]
        if vote == Vote.Like {
            parameters["like"] = "true"
        } else if vote == Vote.Dislike {
            parameters["dislike"] = "true"
        } else if vote == Vote.Neutral {
            parameters["neutral"] = "true"
        }
        requestPOSTWithItineraryResponse(url, parameters: parameters, completion: completion)

    }
    
    func update_itinerary_with_user (itinerary: Itinerary, user: User, completion: (response: Itinerary?, error: NSError?) -> ()) {
        let url = recommender_domain + "/update_itinerary_with_user/"
        let parameters: [String: String] = ["groupID": itinerary.id!, "userEmail": user.email!, "name": user.name!, "profileImageURL": user.profileImageURL!]
        requestPOSTWithItineraryResponse(url, parameters: parameters, completion: completion)
    }
    
    
    func get_itinerary (itinerary: Itinerary, completion: (response: Itinerary?, error: NSError?) -> ()) {
        let url = recommender_domain + "/get_itinerary/"
        let parameters: [String: String] = ["groupID": itinerary.id!]
        requestGETWithItineraryResponse(url, parameters: parameters, completion: completion)
    }
    
    func get_itineraries_for_user (user: User, completion: (response: [Itinerary]?, error: NSError?) -> ()) {
        let url = recommender_domain + "/get_itineraries_for_user/"
        let parameters: [String: String] = ["userEmail": user.email!]
        requestGETWithItinerariesResponse(url, parameters: parameters, completion: completion)
    }
    
    func add_itinerary (itinerary: Itinerary, completion: (response: Itinerary?, error: NSError?) -> ()) {
        let url = self.recommender_domain + "/add_itinerary/"
        let coord = itinerary.city!.location!.coordinate
        let location = "\(coord.latitude),\(coord.longitude)"
        let parameters: [String: String] = ["groupID": itinerary.id!,
            "userEmail": itinerary.creator!.email!,
            "name": itinerary.creator!.name!,
            "tripName": itinerary.tripName!,
            "startDate": DateFormatter.dateTostring(itinerary.startDate)!,
            "numDays" : "\(itinerary.days?.count ?? 0)",
            "location": location,
            "radius": "\(itinerary.city?.radius)" ]
        requestPOSTWithItineraryResponse(url, parameters: parameters, completion: completion)
        
    }
    
    func update_itinerary_with_preference (completion: (response: Itinerary?, error: NSError?) -> ()) {
        let url = recommender_domain + "/restaurants"
        print(url)
        // TODO(jlee);
    }
    
    func remove_itinerary (completion: (response: Itinerary?, error: NSError?) -> ()) {
        let url = recommender_domain + "/restaurants"
        print(url)
        // TODO(jlee);
    }
}