//
//  ContainerViewController.swift
//  Fomo
//
//  Created by Connie Yu on 3/7/16.
//  Copyright © 2016 TeamAwesome. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var tripNameLabel: UIButton!
    
    
    private var selectedViewController: UIViewController!
    private var decisionVC: DecisionViewController!
    private var itineraryVC: ItineraryViewController!
    private var tripVC: TripViewController!
    private var friendsVC: FriendsViewController!
    private var preferencesVC: PreferencesViewController!
    
    private var menuClosedX: CGFloat!
    private var menuOpenX: CGFloat!


    override func viewDidLoad() {
        super.viewDidLoad()

        decisionVC = storyboard!.instantiateViewControllerWithIdentifier("DecisionViewController") as! DecisionViewController
        itineraryVC = storyboard!.instantiateViewControllerWithIdentifier("ItineraryViewController") as! ItineraryViewController
        friendsVC = storyboard!.instantiateViewControllerWithIdentifier("FriendsViewController") as! FriendsViewController
        tripVC = storyboard!.instantiateViewControllerWithIdentifier("TripViewController") as! TripViewController
        preferencesVC = storyboard!.instantiateViewControllerWithIdentifier("PreferencesViewController") as! PreferencesViewController
        
        selectViewController(decisionVC)
    
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        menuOpenX = menuView.frame.size.width / 2
        menuClosedX = -menuView.frame.size.width / 2
    }
    
    
    private func selectViewController(viewController: UIViewController) {
        if let oldViewController = selectedViewController {
            if oldViewController == viewController {
                return
            }
            oldViewController.willMoveToParentViewController(nil)
            oldViewController.view.removeFromSuperview()
            oldViewController.removeFromParentViewController()
        }
        self.addChildViewController(viewController)
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        containerView.addSubview(viewController.view)
        viewController.didMoveToParentViewController(self)
        selectedViewController = viewController
    }
    
    
    @IBAction func onPan(sender: UIPanGestureRecognizer) {
        let velocity = sender.velocityInView(view)

        if sender.state == UIGestureRecognizerState.Began {
            if velocity.x > 0 {
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 5, options: [], animations: { () -> Void in
                    self.menuView.center = CGPointMake(self.menuOpenX, self.menuView.center.y)
                    }, completion: nil)
            } else {
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 5, options: [], animations: { () -> Void in
                    self.menuView.center = CGPointMake(self.menuClosedX, self.menuView.center.y)
                    }, completion: nil)
            }
        }
    }
    
    @IBAction func onBrowsePressed(sender: AnyObject) {
        selectViewController(decisionVC)
    }
    
    @IBAction func onTripPressed(sender: AnyObject) {
        selectViewController(itineraryVC)
    }
    
    @IBAction func onNewTripPressed(sender: AnyObject) {
        selectViewController(tripVC)
    }
    
    @IBAction func onInviteFriendsPressed(sender: AnyObject) {
        selectViewController(friendsVC)
    }
    
    
    @IBAction func onProfileSettingsPressed(sender: AnyObject) {
        selectViewController(preferencesVC)
    }
    

    
}
