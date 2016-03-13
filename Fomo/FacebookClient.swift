//
//  FacebookClient.swift
//  Fomo
//
//  Created by Jennifer Lee on 3/7/16.
//  Copyright © 2016 TeamAwesome. All rights reserved.
//

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
    func getUserInfo(accessToken: FBSDKAccessToken) {
        let req = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email,name"], tokenString: accessToken.tokenString, version: nil, HTTPMethod: "GET")
        req.startWithCompletionHandler({ (connection, result, error : NSError!) -> Void in
            if(error == nil){
                print("result \(result)")
                let user_dict = [
                    "email": result["email"] as! String,
                    "name": result["name"] as! String,
                    "id": result["id"] as! String,
                ]
                print("STORING")
                Cache.currentUser = User(dictionary: user_dict)
                FacebookClient.sharedInstance.getFriends(accessToken, offset: 0)
            } else {
                print("error \(error)")
            }
        })
    }
    
    func getAllFriends(accessToken: FBSDKAccessToken) {
        let total_count = self.page_size
        var finished = false
        var page_num = 0
        while(!finished) {
            let offset = page_num * self.page_size
            getFriends(accessToken, offset: offset)
            
            if offset + self.page_size > total_count {
                finished = true
                print(total_count)
            }
            page_num++
        }
    }
    
    func getFriends(accessToken: FBSDKAccessToken, offset: Int) {
        let parameters: [NSObject: AnyObject] = [
            "limit": self.page_size,
//            "offset": offset,
//            "fields": "data",
        ]
        print(Cache.currentUser)
        let graphPath = "me/taggable_friends"
        let req = FBSDKGraphRequest(graphPath: graphPath, parameters: parameters, tokenString: accessToken.tokenString, version: nil, HTTPMethod: "GET")
        req.startWithCompletionHandler({ (connection, result, error : NSError!) -> Void in
            if(error == nil){
                print("result \(result["data"])")
                let paging = result["paging"] as? NSDictionary
                let cursors = paging!["cursors"] as? NSDictionary
                print("paging \(cursors!["after"] as! String)")
            } else {
                
            }
        })
    }
    
}
