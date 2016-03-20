//
// FriendsViewController.swift
// ============================


import UIKit
import AFNetworking


class FriendsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let popupView: UIView = UIView.newAutoLayoutView()
    let friendsTableView: UITableView = UITableView.newAutoLayoutView()
    let buttonContainer: UIView = UIView.newAutoLayoutView()
    let cancelButton: UIButton = UIButton.newAutoLayoutView()
    let inviteButton: UIButton = UIButton.newAutoLayoutView()
    
    
    var didSetupConstraints = false

    var friends: [User] = [User.generateTestInstance(), User.generateTestInstance(), User.generateTestInstance(), User.generateTestInstance(), User.generateTestInstance()]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        setUpNavigationBar()

//        Cache
    }

    override func loadView() {
        view = UIView()
        
        view.backgroundColor = UIColor.clearColor()
        
        popupView.layer.cornerRadius = 10
        popupView.layer.borderColor = UIColor.blackColor().CGColor
        popupView.layer.borderWidth = 0.25
        popupView.layer.shadowColor = UIColor.blackColor().CGColor
        popupView.layer.shadowOpacity = 0.6
        popupView.layer.shadowRadius = 15
        popupView.layer.shadowOffset = CGSize(width: 5, height: 5)
        popupView.layer.masksToBounds = true
        
        buttonContainer.backgroundColor = UIColor.fomoHighlight()
        cancelButton.setTitle("Cancel", forState: UIControlState.Normal)
        cancelButton.addTarget(self, action: "onCancelPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        inviteButton.setTitle("Invite", forState: UIControlState.Normal)
        inviteButton.addTarget(self, action: "onInvitePressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        view.addSubview(popupView)
        popupView.addSubview(friendsTableView)
        popupView.addSubview(buttonContainer)
        buttonContainer.addSubview(cancelButton)
        buttonContainer.addSubview(inviteButton)

        view.setNeedsUpdateConstraints()
    }

    override func updateViewConstraints() {
        if !didSetupConstraints {
            
            popupView.autoPinToTopLayoutGuideOfViewController(self, withInset: 50)
            popupView.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 50)
            popupView.autoPinEdgeToSuperviewEdge(.Left, withInset: 20)
            popupView.autoPinEdgeToSuperviewEdge(.Right, withInset: 20)
            
            friendsTableView.autoPinEdgeToSuperviewEdge(.Top)
            friendsTableView.autoPinEdgeToSuperviewEdge(.Left)
            friendsTableView.autoPinEdgeToSuperviewEdge(.Right)

            buttonContainer.autoPinEdge(.Top, toEdge: .Bottom, ofView: friendsTableView)
            buttonContainer.autoPinEdgeToSuperviewEdge(.Left)
            buttonContainer.autoPinEdgeToSuperviewEdge(.Right)
            buttonContainer.autoPinEdgeToSuperviewEdge(.Bottom)
            buttonContainer.autoSetDimension(.Height, toSize: 50)
            
            cancelButton.autoAlignAxisToSuperviewAxis(.Horizontal)
            cancelButton.autoSetDimension(.Width, toSize: 75)
            cancelButton.autoPinEdgeToSuperviewEdge(.Left, withInset: 5)
            
            inviteButton.autoAlignAxisToSuperviewAxis(.Horizontal)
            inviteButton.autoMatchDimension(.Width, toDimension: .Width, ofView: cancelButton)
            inviteButton.autoPinEdgeToSuperviewEdge(.Right, withInset: 5)

            didSetupConstraints = true
        }

        super.updateViewConstraints()
    }

    func setUpNavigationBar() {
        self.title = "Invite Friends"
    }

    func onCancelPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("unwindCancelSegue", sender: self)
    }
    
    func onInvitePressed(sender: AnyObject) {
        // TODO: update trip guests array
        self.performSegueWithIdentifier("unwindInviteSegue", sender: self)
    }
    
    // Friends TableView

    func setUpTableView() {
        print(Cache.currentFriends)
        
        friendsTableView.delegate = self
        friendsTableView.dataSource = self
        friendsTableView.rowHeight = UITableViewAutomaticDimension
        friendsTableView.estimatedRowHeight = 100
        friendsTableView.registerClass(FriendCell.self, forCellReuseIdentifier: "CodePath.Fomo.FriendCell")
        friendsTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        friendsTableView.backgroundColor = UIColor.fomoBackground()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CodePath.Fomo.FriendCell", forIndexPath: indexPath) as! FriendCell
        configureCell(cell, indexPath: indexPath)
        return cell
    }

    func configureCell(cell: FriendCell, indexPath: NSIndexPath) {
        let friend = friends[indexPath.row]
        cell.profilePhoto.setImageWithURL(NSURL(string: friend.profileImageURL!)!)
        cell.friendName.text = friend.name!
        cell.friendName.textColor = UIColor.fomoTextColor()
        cell.backgroundColor = UIColor.fomoBackground()
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        displayTodo("Jenn adds friend")
    }

    func displayTodo(todo: String) {
        let alertController = UIAlertController(title: "Fomo", message:"TODO: \(todo)", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        presentViewController(alertController, animated: true, completion: nil)
    }
}
