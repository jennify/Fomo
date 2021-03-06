//
// FacebookClient.swift
// ============================


import UIKit
import BDBOAuth1Manager


class FacebookClient: BDBOAuth1RequestOperationManager {
    class var sharedInstance: FacebookClient {
        struct Static {
            static let instance = FacebookClient()
        }
        return Static.instance
    }
    let page_size = 20
    func getUserInfo(accessToken: FBSDKAccessToken, completion: () -> ()) {
        let req = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email,name,picture{url}"], tokenString: accessToken.tokenString, version: nil, HTTPMethod: "GET")
        req.startWithCompletionHandler({ (connection, result, error : NSError!) -> Void in
            if(error == nil){
                let responseDict = result as? NSDictionary
                Cache.currentUser = User(dictionary: responseDict!)
                FacebookClient.sharedInstance.getFriends(accessToken, afterCursor: nil)
            } else {
                print("Facebook error \(error)")
            }
            completion()
        })
    }

    
    func getFriends(accessToken: FBSDKAccessToken, afterCursor: String?) {
        var parameters: [NSObject: AnyObject] = [
            "limit": self.page_size,
            "fields": "name,picture",
        ]
        if afterCursor != nil {
            parameters["after"] = afterCursor
        }
        
        let graphPath = "me/taggable_friends"
        let req = FBSDKGraphRequest(graphPath: graphPath, parameters: parameters, tokenString: accessToken.tokenString, version: nil, HTTPMethod: "GET")
        
        req.startWithCompletionHandler({ (connection, result, error : NSError!) -> Void in
            if(error == nil){
                let data = result["data"] as? [NSDictionary]
                let friends = User.usersWithArray(data!)
                Cache.addFriendPage(friends)
                let paging = result["paging"] as? NSDictionary
                let cursors = paging!["cursors"] as? NSDictionary
                let afterCursor = cursors!["after"] as! String
                if paging!["next"] != nil {
                    self.getFriends(accessToken, afterCursor: afterCursor)
                } else {
                    // Finished downloading friend list.
                     print("Finished downloading all friends.")
                }
                
            } else {
                print("Facebook error \(error)")
            }
        })
    }
}