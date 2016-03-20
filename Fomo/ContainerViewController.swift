//
// ContainerViewController.swift
// =============================


import UIKit
import PureLayout


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
    
    var selectedViewController: UIViewController!
    var loginVC: LoginViewController!
    var decisionVC: DecisionCardViewController!
    var browseVC: BrowseViewController!
    var attractionVC: AttractionViewController!
    var itineraryVC: ItineraryViewController!
    var cityVC: CityViewController!
    var tripVC: TripViewController!
    var friendsVC: FriendsViewController!
    var preferencesVC: PreferencesViewController!
    var doneVC: DoneViewController!
    
    var menuClosedX: CGFloat!
    var menuOpenX: CGFloat!

    var didSetupConstraints = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpMenu()
        setUpViewControllers()
        setUpNavigationBar()
    }
    
    func setUpMenu() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onPan:")
        view.addGestureRecognizer(panGestureRecognizer)
        
        let bgColor = UIColor.fomoHamburgerBGColor()
        let textColor = UIColor.fomoHamburgerTextColor()

        menuView.backgroundColor = bgColor
        leftBorder.backgroundColor = bgColor
        rightBorder.backgroundColor = bgColor
        border1.backgroundColor = bgColor
        border2.backgroundColor = bgColor
        border3.backgroundColor = bgColor
        
        // TODO: currentUser.name
        profileImage.image = UIImage(named: "neutral")
        profileNameLabel.text = "Name"
        
        let hmbrgerTxtSize : CGFloat = 17
        profileNameLabel.textColor = textColor
        profileNameLabel.font = UIFont.fomoBold(hmbrgerTxtSize)
        browseButton.titleLabel!.font = UIFont.fomoBold(hmbrgerTxtSize)
        tripButton.titleLabel!.font = UIFont.fomoBold(hmbrgerTxtSize)
        createButton.titleLabel!.font = UIFont.fomoBold(hmbrgerTxtSize)
        inviteButton.titleLabel!.font = UIFont.fomoBold(hmbrgerTxtSize)
        settingsButton.titleLabel!.font = UIFont.fomoBold(hmbrgerTxtSize)

        browseIcon.image = UIImage(named: "globe")
        browseButton.setTitle("Browse", forState: UIControlState.Normal)
        browseButton.addTarget(self, action: "onBrowsePressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        tripIcon.image = UIImage(named: "plane")
        tripButton.setTitle("Trip", forState: UIControlState.Normal)
        tripButton.addTarget(self, action: "onTripPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        createIcon.image = UIImage(named: "plus")
        createButton.setTitle("New Trip", forState: UIControlState.Normal)
        createButton.addTarget(self, action: "onNewTripPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        inviteIcon.image = UIImage(named: "invite")
        inviteButton.setTitle("Invite Friends", forState: UIControlState.Normal)
        inviteButton.addTarget(self, action: "onInviteFriendsPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        settingsIcon.image = UIImage(named: "settings")
        settingsButton.setTitle("Profile Settings", forState: UIControlState.Normal)
        settingsButton.addTarget(self, action: "onProfileSettingsPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        profileImage.image = profileImage.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        profileImage.tintColor = textColor
        browseIcon.image = browseIcon.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        browseIcon.tintColor = textColor
        tripIcon.image = tripIcon.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        tripIcon.tintColor = textColor
        createIcon.image = createIcon.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        createIcon.tintColor = textColor
        inviteIcon.image = inviteIcon.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        inviteIcon.tintColor = textColor
        settingsIcon.image = settingsIcon.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        settingsIcon.tintColor = textColor
    }
    
    func setUpViewControllers() {
        loginVC = storyboard!.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
        browseVC = storyboard!.instantiateViewControllerWithIdentifier("BrowseViewController") as! BrowseViewController
        decisionVC = DecisionCardViewController()
        attractionVC = storyboard!.instantiateViewControllerWithIdentifier("AttractionViewController") as! AttractionViewController
        itineraryVC = storyboard!.instantiateViewControllerWithIdentifier("ItineraryViewController") as! ItineraryViewController
        cityVC = storyboard!.instantiateViewControllerWithIdentifier("CityViewController") as! CityViewController
        tripVC = storyboard!.instantiateViewControllerWithIdentifier("TripViewController") as! TripViewController
        friendsVC = storyboard!.instantiateViewControllerWithIdentifier("FriendsViewController") as! FriendsViewController
        preferencesVC = storyboard!.instantiateViewControllerWithIdentifier("PreferencesViewController") as! PreferencesViewController
        doneVC = storyboard!.instantiateViewControllerWithIdentifier("DoneViewController") as! DoneViewController  
        
        selectViewController(decisionVC)
    }

    func setUpNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "hamburger"), style: .Plain, target: self, action: "toggleMenu")
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
            menuView.autoPinToTopLayoutGuideOfViewController(self, withInset: 0)
            menuView.autoPinEdgeToSuperviewEdge(.Bottom)
            menuView.autoPinEdge(.Right, toEdge: .Left, ofView: view)
            menuView.autoConstrainAttribute(.Width, toAttribute: .Width, ofView: view, withMultiplier: 0.6)
            
            leftBorder.autoPinEdgeToSuperviewEdge(.Top)
            leftBorder.autoPinEdgeToSuperviewEdge(.Bottom)
            leftBorder.autoSetDimension(.Width, toSize: 1)
            leftBorder.autoPinEdge(.Right, toEdge: .Left, ofView: profileView, withOffset: 1)

            rightBorder.autoPinEdgeToSuperviewEdge(.Top)
            rightBorder.autoPinEdgeToSuperviewEdge(.Bottom)
            rightBorder.autoSetDimension(.Width, toSize: 1)
            rightBorder.autoPinEdge(.Left, toEdge: .Right, ofView: profileView, withOffset: -1)

            profileView.autoPinEdgeToSuperviewEdge(.Top)
            profileView.autoPinEdgeToSuperviewEdge(.Left)
            profileView.autoPinEdgeToSuperviewEdge(.Right)
            profileView.autoSetDimension(.Height, toSize: 100)

            profileImage.autoAlignAxis(.Vertical, toSameAxisOfView: profileView)
            profileImage.autoPinEdge(.Bottom, toEdge: .Top, ofView: profileNameLabel, withOffset: -10)
            profileImage.autoSetDimension(.Height, toSize: 40)
            profileImage.autoSetDimension(.Width, toSize: 40)
            
            profileNameLabel.autoAlignAxis(.Vertical, toSameAxisOfView: profileView)
            profileNameLabel.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: profileView, withOffset: -10)
            
            border1.autoPinEdge(.Top, toEdge: .Bottom, ofView: profileView)
            border1.autoPinEdgeToSuperviewEdge(.Left)
            border1.autoPinEdgeToSuperviewEdge(.Right)
            border1.autoSetDimension(.Height, toSize: 1)
            
            browseIcon.autoPinEdgeToSuperviewEdge(.Left, withInset: 15)
            browseIcon.autoPinEdge(.Top, toEdge: .Bottom, ofView: border1, withOffset: 15)
            browseIcon.autoSetDimension(.Height, toSize: 20)
            browseIcon.autoSetDimension(.Width, toSize: 20)
            browseIcon.autoAlignAxis(.Horizontal, toSameAxisOfView: browseButton)
            browseButton.autoPinEdge(.Left, toEdge: .Right, ofView: browseIcon, withOffset: 10)
            
            border2.autoPinEdge(.Top, toEdge: .Bottom, ofView: browseButton, withOffset: 15)
            border2.autoPinEdgeToSuperviewEdge(.Left)
            border2.autoPinEdgeToSuperviewEdge(.Right)
            border2.autoSetDimension(.Height, toSize: 1)

            tripIcon.autoPinEdge(.Top, toEdge: .Bottom, ofView: border2, withOffset: 15)
            tripIcon.autoConstrainAttribute(.Left, toAttribute: .Left, ofView: browseIcon)
            tripIcon.autoSetDimension(.Height, toSize: 20)
            tripIcon.autoSetDimension(.Width, toSize: 20)
            tripIcon.autoAlignAxis(.Horizontal, toSameAxisOfView: tripButton)
            tripButton.autoConstrainAttribute(.Left, toAttribute: .Left, ofView: browseButton)
            
            border3.autoPinEdge(.Top, toEdge: .Bottom, ofView: tripButton, withOffset: 15)
            border3.autoPinEdgeToSuperviewEdge(.Left)
            border3.autoPinEdgeToSuperviewEdge(.Right)
            border3.autoSetDimension(.Height, toSize: 1)

            createIcon.autoPinEdge(.Top, toEdge: .Bottom, ofView: border3, withOffset: 15)
            createIcon.autoConstrainAttribute(.Left, toAttribute: .Left, ofView: tripIcon)
            createIcon.autoSetDimension(.Height, toSize: 20)
            createIcon.autoSetDimension(.Width, toSize: 20)
            createIcon.autoAlignAxis(.Horizontal, toSameAxisOfView: createButton)
            createButton.autoConstrainAttribute(.Left, toAttribute: .Left, ofView: tripButton)

            inviteIcon.autoPinEdge(.Bottom, toEdge: .Top, ofView: settingsIcon, withOffset: -15)
            inviteIcon.autoConstrainAttribute(.Left, toAttribute: .Left, ofView: createIcon)
            inviteIcon.autoSetDimension(.Height, toSize: 20)
            inviteIcon.autoSetDimension(.Width, toSize: 20)
            inviteIcon.autoAlignAxis(.Horizontal, toSameAxisOfView: inviteButton)
            inviteButton.autoConstrainAttribute(.Left, toAttribute: .Left, ofView: createButton)
            
            settingsIcon.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 15)
            settingsIcon.autoConstrainAttribute(.Left, toAttribute: .Left, ofView: inviteIcon)
            settingsIcon.autoSetDimension(.Height, toSize: 20)
            settingsIcon.autoSetDimension(.Width, toSize: 20)
            settingsIcon.autoAlignAxis(.Horizontal, toSameAxisOfView: settingsButton)
            settingsButton.autoConstrainAttribute(.Left, toAttribute: .Left, ofView: inviteButton)

            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        menuOpenX = menuView.frame.size.width / 2
        menuClosedX = -menuView.frame.size.width / 2
    }
    
    func selectViewController(viewController: UIViewController) {
        if let previousViewController = selectedViewController {
            if previousViewController == viewController {
                toggleMenu()
                return
            }
            previousViewController.willMoveToParentViewController(nil)
            previousViewController.view.removeFromSuperview()
            previousViewController.removeFromParentViewController()
        }
        self.addChildViewController(viewController)
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        containerView.addSubview(viewController.view)
        viewController.didMoveToParentViewController(self)
        selectedViewController = viewController
    }
    
    func toggleMenu() {
        if self.menuView.center.x < 0 {
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 5, options: [], animations: { () -> Void in
                self.menuView.center = CGPointMake(self.menuOpenX, self.menuView.center.y)
            }, completion: nil)
        } else {
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 5, options: [], animations: { () -> Void in
                self.menuView.center = CGPointMake(self.menuClosedX, self.menuView.center.y)
            }, completion: nil)
        }
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
        selectViewController(cityVC)
    }
    
    func onInviteFriendsPressed(sender: AnyObject) {
        selectViewController(friendsVC)
    }
    
    func onProfileSettingsPressed(sender: AnyObject) {
        selectViewController(preferencesVC)
    }
}
