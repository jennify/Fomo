//
//  ContainerViewController.swift
//  Fomo
//
//  Created by Connie Yu on 3/7/16.
//  Copyright © 2016 TeamAwesome. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    let containerView: UIView = UIView.newAutoLayoutView()
    let menuView: UIView = UIView.newAutoLayoutView()

    let leftBorder: UIView = UIView.newAutoLayoutView()
    let rightBorder: UIView = UIView.newAutoLayoutView()

    let profileView: UIView = UIView.newAutoLayoutView()
    let profileImage: UIImageView = UIImageView.newAutoLayoutView()
    let profileNameLabel: UILabel = UILabel.newAutoLayoutView()
    let border1: UIView = UIView.newAutoLayoutView()

    let browseIcon: UIImageView = UIImageView.newAutoLayoutView()
    let browseButton: UIButton = UIButton.newAutoLayoutView()
    let border2: UIView = UIView.newAutoLayoutView()

    let tripIcon: UIImageView = UIImageView.newAutoLayoutView()
    let tripButton: UIButton = UIButton.newAutoLayoutView()
    let border3: UIView = UIView.newAutoLayoutView()

    let createIcon: UIImageView = UIImageView.newAutoLayoutView()
    let createButton: UIButton = UIButton.newAutoLayoutView()

    let inviteIcon: UIImageView = UIImageView.newAutoLayoutView()
    let inviteButton: UIButton = UIButton.newAutoLayoutView()
    let settingsIcon: UIImageView = UIImageView.newAutoLayoutView()
    let settingsButton: UIButton = UIButton.newAutoLayoutView()

    let currentUser = Cache.currentUser
    
    private var selectedViewController: UIViewController!
    private var decisionVC: DecisionViewController!
    private var itineraryVC: ItineraryViewController!
    private var tripVC: TripViewController!
    private var friendsVC: FriendsViewController!
    private var preferencesVC: PreferencesViewController!
    
    private var menuClosedX: CGFloat!
    private var menuOpenX: CGFloat!

    var didSetupConstraints = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpMenu()
        setUpViewControllers()
    }
    
    func setUpMenu() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onPan:")
        view.addGestureRecognizer(panGestureRecognizer)
        
        profileImage.image = UIImage(named: "meh64px")
        profileNameLabel.text = currentUser!.name
        
        browseIcon.image = UIImage(named: "globe24px")
        browseButton.setTitle("Browse", forState: UIControlState.Normal)
        browseButton.addTarget(self, action: "onBrowsePressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        tripIcon.image = UIImage(named: "plane20px")
        tripButton.setTitle("Trip", forState: UIControlState.Normal)
        tripButton.addTarget(self, action: "onTripPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        createIcon.image = UIImage(named: "plus20px")
        createButton.setTitle("New Trip", forState: UIControlState.Normal)
        createButton.addTarget(self, action: "onNewTripPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        inviteIcon.image = UIImage(named: "invite20px")
        inviteButton.setTitle("Invite Friends", forState: UIControlState.Normal)
        inviteButton.addTarget(self, action: "onInviteFriendsPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        settingsIcon.image = UIImage(named: "settings20px")
        settingsButton.setTitle("Profile Settings", forState: UIControlState.Normal)
        settingsButton.addTarget(self, action: "onProfileSettingsPressed:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func setUpViewControllers() {
        decisionVC = storyboard!.instantiateViewControllerWithIdentifier("DecisionViewController") as! DecisionViewController
        itineraryVC = storyboard!.instantiateViewControllerWithIdentifier("ItineraryViewController") as! ItineraryViewController
        friendsVC = storyboard!.instantiateViewControllerWithIdentifier("FriendsViewController") as! FriendsViewController
        tripVC = storyboard!.instantiateViewControllerWithIdentifier("TripViewController") as! TripViewController
        preferencesVC = storyboard!.instantiateViewControllerWithIdentifier("PreferencesViewController") as! PreferencesViewController
        
        selectViewController(decisionVC)
    }

    override func loadView() {
        view = UIView()
        
        view.addSubview(containerView)
        view.addSubview(menuView)
        menuView.addSubview(leftBorder)
        menuView.addSubview(rightBorder)
        menuView.addSubview(profileView)
        profileView.addSubview(profileImage)
        profileView.addSubview(profileNameLabel)
        menuView.addSubview(border1)
        menuView.addSubview(browseIcon)
        menuView.addSubview(browseButton)
        menuView.addSubview(border2)
        menuView.addSubview(tripIcon)
        menuView.addSubview(tripButton)
        menuView.addSubview(border3)
        menuView.addSubview(createIcon)
        menuView.addSubview(createButton)
        menuView.addSubview(inviteIcon)
        menuView.addSubview(inviteButton)
        menuView.addSubview(settingsIcon)
        menuView.addSubview(settingsButton)

        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        if (!didSetupConstraints) {
            containerView.autoPinEdgesToSuperviewEdges()
            menuView.autoPinEdgeToSuperviewEdge(.Top)
            menuView.autoPinEdgeToSuperviewEdge(.Bottom)
            menuView.autoPinEdge(.Right, toEdge: .Left, ofView: view)
            menuView.autoConstrainAttribute(.Width, toAttribute: .Width, ofView: view, withMultiplier: 0.75)

            leftBorder.autoPinEdgeToSuperviewEdge(.Top)
            leftBorder.autoPinEdgeToSuperviewEdge(.Bottom)
            leftBorder.autoSetDimension(.Width, toSize: 1)
            leftBorder.autoPinEdge(.Left, toEdge: .Left, ofView: view)
//            leftBorder.autoConstrainAttribute(.Left, toAttribute: .Left, ofView: view)

            rightBorder.autoPinEdgeToSuperviewEdge(.Top)
            rightBorder.autoPinEdgeToSuperviewEdge(.Bottom)
            rightBorder.autoSetDimension(.Width, toSize: 1)
            rightBorder.autoPinEdge(.Right, toEdge: .Right, ofView: view)
//            rightBorder.autoConstrainAttribute(.Right, toAttribute: .Right, ofView: view)

            profileView.autoPinEdgeToSuperviewEdge(.Top)
            profileView.autoPinEdgeToSuperviewEdge(.Left)
            profileView.autoPinEdgeToSuperviewEdge(.Right)
            profileView.autoSetDimension(.Height, toSize: 100)

            profileImage.autoAlignAxis(.Horizontal, toSameAxisOfView: profileView)
            profileImage.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: profileNameLabel, withOffset: -10)

            profileNameLabel.autoAlignAxis(.Horizontal, toSameAxisOfView: profileView)
            profileNameLabel.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: profileView, withOffset: -10)

            border1.autoPinEdge(.Top, toEdge: .Bottom, ofView: profileView)
            border1.autoPinEdgeToSuperviewEdge(.Left)
            border1.autoPinEdgeToSuperviewEdge(.Right)
            border1.autoSetDimension(.Height, toSize: 1)
            
            browseIcon.autoPinEdgeToSuperviewEdge(.Left, withInset: 10)
            browseIcon.autoSetDimension(.Height, toSize: 20)
            browseIcon.autoSetDimension(.Width, toSize: 20)
            browseIcon.autoAlignAxis(.Vertical, toSameAxisOfView: browseButton)
            browseButton.autoPinEdge(.Left, toEdge: .Right, ofView: browseIcon, withOffset: 10)
            
            border2.autoPinEdge(.Top, toEdge: .Bottom, ofView: browseButton, withOffset: 10)
            border2.autoPinEdgeToSuperviewEdge(.Left)
            border2.autoPinEdgeToSuperviewEdge(.Right)
            border2.autoSetDimension(.Height, toSize: 1)

            tripIcon
            tripIcon.autoSetDimension(.Height, toSize: 20)
            tripIcon.autoSetDimension(.Width, toSize: 20)
            tripIcon.autoAlignAxis(.Vertical, toSameAxisOfView: tripButton)
            tripButton
            
            border3.autoPinEdge(.Top, toEdge: .Bottom, ofView: tripButton, withOffset: 10)
            border3.autoPinEdgeToSuperviewEdge(.Left)
            border3.autoPinEdgeToSuperviewEdge(.Right)
            border3.autoSetDimension(.Height, toSize: 1)

            createIcon
            createIcon.autoSetDimension(.Height, toSize: 20)
            createIcon.autoSetDimension(.Width, toSize: 20)
            createIcon.autoAlignAxis(.Vertical, toSameAxisOfView: createButton)
            createButton
            
            inviteIcon
            inviteIcon.autoSetDimension(.Height, toSize: 20)
            inviteIcon.autoSetDimension(.Width, toSize: 20)
            inviteIcon.autoAlignAxis(.Vertical, toSameAxisOfView: inviteButton)
            inviteButton.autoPinEdge(.Bottom, toEdge: .Top, ofView: settingsButton, withOffset: 10)
            
            settingsIcon
            settingsIcon.autoSetDimension(.Height, toSize: 20)
            settingsIcon.autoSetDimension(.Width, toSize: 20)
            settingsIcon.autoAlignAxis(.Vertical, toSameAxisOfView: settingsButton)
            settingsButton
            settingsButton.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 10)

            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
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
    
    
    func onPan(sender: UIPanGestureRecognizer) {
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
    
    func onBrowsePressed(sender: AnyObject) {
        selectViewController(decisionVC)
    }
    
    func onTripPressed(sender: AnyObject) {
        selectViewController(itineraryVC)
    }
    
    func onNewTripPressed(sender: AnyObject) {
        selectViewController(tripVC)
    }
    
    func onInviteFriendsPressed(sender: AnyObject) {
        selectViewController(friendsVC)
    }
    
    func onProfileSettingsPressed(sender: AnyObject) {
        selectViewController(preferencesVC)
    }
}
