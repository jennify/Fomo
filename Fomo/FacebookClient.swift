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
    
    func getUserInfo(token: FBSDKAccessToken) {
        let accessToken = token
        let req = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email,name"], tokenString: accessToken.tokenString, version: nil, HTTPMethod: "GET")
        req.startWithCompletionHandler({ (connection, result, error : NSError!) -> Void in
            if(error == nil){
                print("result \(result)")
                let user_dict = [
                    "email": result["email"] as! String,
                    "name": result["name"] as! String,
                ]
                //                let user = User(dictionary: user_dict)
                //                print(user)
            } else {
                print("error \(error)")
            }
        })
        
    }
}
