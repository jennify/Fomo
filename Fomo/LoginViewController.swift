//
//  ViewController.swift
//  Fomo
//
//  Created by Jennifer Lee on 2/22/16.
//  Copyright © 2016 TeamAwesome. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = FBSDKLoginButton(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        loginButton.center = CGPoint(x: view.center.x, y: view.center.y + 100)
        loginButton.delegate = self
        loginButton.readPermissions = ["public_profile", "email", "user_friends"];
        view.addSubview(loginButton)
        
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        // Fired when open url has happened and exited on success or failure.

        if result.isCancelled {
            // Login is canceled
            NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: userDidLogoutNotification, object: nil))
        } else {
            // Login is successful, proceed
            print(result.grantedPermissions)
            print(result.declinedPermissions)
            print(result.token)
            

            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("DecisionViewController") as! DecisionViewController
            self.presentViewController(vc, animated: true, completion: nil)
            
        }
        
    }
    
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        // Fired when the login button is about to be fired.
        return true
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        // Fired when user logs out.
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: userDidLogoutNotification, object: nil))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

