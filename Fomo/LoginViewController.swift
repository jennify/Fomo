//
// LoginViewController.swift
// ============================


import UIKit


class LoginViewController: UIViewController, FBSDKLoginButtonDelegate, FBSDKSharingDelegate {
    var titleLabel: UILabel = UILabel.newAutoLayoutView()
    var didSetupConstraints = false
    var loginButton : FBSDKLoginButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginButton = FBSDKLoginButton(frame: CGRect(x: 0, y: 0, width: 100, height: 35))
        view.addSubview(loginButton)
        
        
        loginButton.center = CGPoint(x: view.center.x, y: view.center.y + 100)
        loginButton.delegate = self
        loginButton.readPermissions = ["public_profile", "email", "user_friends"];
        
        titleLabel.text = "fomo"
        titleLabel.font = UIFont(name: "Georgia-Italic", size: 50)
        titleLabel.textColor = UIColor.fomoLight()
        
        titleLabel.textAlignment = .Center
        titleLabel.sizeToFit()
        
        view.addSubview(titleLabel)
        
    }
    
    func sharer(sharer: FBSDKSharing!, didCompleteWithResults results: [NSObject : AnyObject]!) {
        print("Sharer did complete")
    }
    
    func sharer(sharer: FBSDKSharing!, didFailWithError error: NSError!) {
        print("Sharer fail error \(error)")
    }
    
    func sharerDidCancel(sharer: FBSDKSharing!) {
        print("Canceled")
    }
    
    
    override func updateViewConstraints() {
        if !didSetupConstraints {
            titleLabel.autoAlignAxisToSuperviewAxis(.Vertical)
            titleLabel.autoAlignAxis(.Horizontal, toSameAxisOfView: self.view, withOffset: -140)
            
            didSetupConstraints = true
        }
        super.updateViewConstraints()
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        // Fired when open url has happened and exited on success or failure.
        
        if result.isCancelled {
            NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: userDidLogoutNotification, object: nil))
        } else {
            
            FacebookClient.sharedInstance.getUserInfo(result.token) {
                () in
                let user = Cache.currentUser!
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                RecommenderClient.sharedInstance.get_itineraries_for_user(user) {
                    (response, error) -> () in
                    
                    if error != nil || response == nil {
                        print("No Itinerary detected")
                        let vc = storyboard.instantiateViewControllerWithIdentifier("FomoNavigationController") as! UINavigationController
                        let container = vc.topViewController as? ContainerViewController
                        container?.initialVC = storyboard.instantiateViewControllerWithIdentifier("CityViewController") as! CityViewController
                        self.presentViewController(vc, animated: true, completion: nil)
                        
                    } else {
                        print("Itinerary \(Cache.itinerary?.tripName) detected")
                        let vc = storyboard.instantiateViewControllerWithIdentifier("FomoNavigationController") as! UINavigationController
                        let container = vc.topViewController as? ContainerViewController
                        container?.initialVC = self.storyboard!.instantiateViewControllerWithIdentifier("PreferencesViewController") as!
                        PreferencesViewController
                        self.presentViewController(vc, animated: true, completion: nil)
                    }
                }
            }
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
}