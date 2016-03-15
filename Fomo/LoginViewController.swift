//
// LoginViewController.swift
// ============================


import UIKit


class LoginViewController: UIViewController, FBSDKLoginButtonDelegate, FBSDKSharingDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = FBSDKLoginButton(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        loginButton.center = CGPoint(x: view.center.x, y: view.center.y + 100)
        loginButton.delegate = self
        loginButton.readPermissions = ["public_profile", "email", "user_friends"];
        view.addSubview(loginButton)
        
        //        let send = FBSDKSendButton()
        //        let linkContent = FBSDKShareLinkContent()
        //        linkContent.contentTitle = "Hello"
        //        linkContent.contentDescription = "Googs"
        //        linkContent.contentURL = NSURL(string: "https://developers.facebook.com")
        //        send.shareContent = linkContent
        //        send.center = view.center
        //        view.addSubview(send)
        //        FBSDKShareDialog.showFromViewController(self, withContent: linkContent, delegate: self)
        
        
    }
    
    func sharer(sharer: FBSDKSharing!, didCompleteWithResults results: [NSObject : AnyObject]!) {
        print("sharer did complete")
    }
    
    func sharer(sharer: FBSDKSharing!, didFailWithError error: NSError!) {
        print("sharer fail error")
        print(error)
    }
    
    func sharerDidCancel(sharer: FBSDKSharing!) {
        print("canceled")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // TODO(jlee): Remove
        //        sendFriendInviteToItinerary(self, shareMessage: nil, itinerary: Itinerary.generateTestInstance())
    }
    
    
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        // Fired when open url has happened and exited on success or failure.
        
        if result.isCancelled {
            // Login is canceled
            NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: userDidLogoutNotification, object: nil))
        } else {
            // Login is successful, proceed
            //            print(result.grantedPermissions)
            //            print(result.declinedPermissions)
            //            print(result.token)
            
            // TODO(jlee)
            FacebookClient.sharedInstance.getUserInfo(result.token)
            
            self.performSegueWithIdentifier("loginSegue", sender: self)
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