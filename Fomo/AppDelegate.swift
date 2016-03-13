//
//  AppDelegate.swift
//  Fomo
//
//  Created by Jennifer Lee on 2/22/16.
//  Copyright © 2016 TeamAwesome. All rights reserved.
//

import UIKit
import CoreData

// All Notification Types Here
let userDidLogoutNotification = "kUserDidLogoutNotification"

let DEBUG = "none"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var storyboard = UIStoryboard(name: "Main", bundle: nil)


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)


        NSNotificationCenter.defaultCenter().addObserver(self, selector: "userDidLogout", name: userDidLogoutNotification, object: nil)
        if Cache.currentUser != nil {
            // If user has already logged in
            let vc = storyboard.instantiateViewControllerWithIdentifier("FomoNavigationController") as UIViewController
            window?.rootViewController = vc
        }


        if DEBUG == "jlee" {
            self.jleeDebugging()
        } else if DEBUG == "christian" {
            self.christianDebugging()
        } else if DEBUG == "connie" {
            self.connieDebugging()
        }

        return true
    }
    func connieDebugging() {
        // Debugging Entry Point - skip login
        if (true) {
            let vc = storyboard.instantiateViewControllerWithIdentifier("FomoNavigationController") as UIViewController
            window?.rootViewController = vc
        }
        
        // Debugging Entry Point for Decision View Controller
        if (false) {
            let vc = storyboard.instantiateViewControllerWithIdentifier("DecisionViewController") as! DecisionViewController
            window?.rootViewController = vc
        }
    }
    func christianDebugging() {
        // Debugging Entry Point for Itinerary View Controller
        if (false) {
            let itineraryViewController = ItineraryViewController()
            let navController = UINavigationController()
            navController.navigationBar.translucent = false
            navController.viewControllers = [itineraryViewController]
            window?.rootViewController = navController
        }
        
        // Debugging Entry Point for Itinerary View Controller
        if (true) {
            let tripViewController = TripViewController()
            let navController = UINavigationController()
            navController.navigationBar.translucent = false
            navController.viewControllers = [tripViewController]
            window?.rootViewController = navController
        }

        // Debugging Entry Point for Preferences View Controller
        if (false) {
            let preferencesViewController = PreferencesViewController()
            let navController = UINavigationController()
            navController.navigationBar.translucent = false
            navController.viewControllers = [preferencesViewController]
            window?.rootViewController = navController
        }

        // Debugging Entry Point for Friends View Controller
        if (false) {
            let friendsViewController = FriendsViewController()
            let navController = UINavigationController()
            navController.navigationBar.translucent = false
            navController.viewControllers = [friendsViewController]
            window?.rootViewController = navController
        }
    }
    func jleeDebugging() {
        print("Begin")
        RecommenderClient.sharedInstance.add_itinerary(Itinerary.generateTestInstance()) { (response: Itinerary?, error: NSError?) -> () in

            if error != nil {
                print(error)
                displayAlert((self.window?.rootViewController)!, error: error!)
            } else {
                print("Initial recommender hooked up")
            }
        }

        // How to use the recommender:
        //        RecommenderClient.sharedInstance.get_recommendations_with_user(User.generateTestInstance(), groupID: Itinerary.generateTestInstance().id!) {
        //            (response: Recommendation?, error: NSError? ) in
        //
        //            if error != nil {
        //                print(error)
        //                displayAlert((self.window?.rootViewController)!, error: error!)
        //            } else {
        //                print("Initial recommender hooked up")
        //            }
        //        }
        //        let fakeItinerary = Itinerary.generateTestInstance()
        //        let fakeAttraction = Attraction.generateTestInstance(City.generateTestInstance())
        //        RecommenderClient.sharedInstance.update_itinerary_with_vote(fakeItinerary, attraction: fakeAttraction, user: User.generateTestInstance(), vote: Vote.Like) {
        //            (response, error) -> () in
        //
        //            if error != nil {
        //                print(error)
        //                displayAlert((self.window?.rootViewController)!, error: error!)
        //            } else {
        //                print("Initial recommender hooked up")
        //            }
        //        }
        //        RecommenderClient.sharedInstance.get_itineraries_for_user(User.generateTestInstance()) {
        //            (response, error) -> () in
        //
        //            if error != nil {
        //                print(error)
        //                displayAlert((self.window?.rootViewController)!, error: error!)
        //            } else {
        //                print("Initial recommender hooked up")
        //            }
        //        }
    }

    func userDidLogout() {
        let vc = storyboard.instantiateViewControllerWithIdentifier("LoginViewController")
        window?.rootViewController = vc
    }

    func application(application: UIApplication,
        openURL url: NSURL,
        sourceApplication: String?,
        annotation: AnyObject) -> Bool {
            return FBSDKApplicationDelegate.sharedInstance().application(
                application,
                openURL: url,
                sourceApplication: sourceApplication,
                annotation: annotation)
    }


    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        FBSDKAppEvents.activateApp()

    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "CodePath.Fomo" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("Fomo", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason

            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }

        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }


}

