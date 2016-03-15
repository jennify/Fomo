//
// FriendsViewController.swift
// ============================


import UIKit
import AFNetworking


class FriendsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let friendsTableView: UITableView = UITableView.newAutoLayoutView()
    var didSetupConstraints = false

    var friends: [User] = [User.generateTestInstance(), User.generateTestInstance()]

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
        setUpNavigationBar()
    }

    override func loadView() {
        view = UIView()

        view.addSubview(friendsTableView)

        view.setNeedsUpdateConstraints()
    }

    override func updateViewConstraints() {
        if !didSetupConstraints {
            friendsTableView.autoPinToTopLayoutGuideOfViewController(self, withInset: 0)
            friendsTableView.autoPinEdgeToSuperviewEdge(.Left)
            friendsTableView.autoPinEdgeToSuperviewEdge(.Right)
            friendsTableView.autoPinEdgeToSuperviewEdge(.Bottom)

            didSetupConstraints = true
        }

        super.updateViewConstraints()
    }

    func setUpNavigationBar() {
        navigationItem.title = "Invite Friends"
    }

    //# MARK: Friends TableView

    func setUpTableView() {
        friendsTableView.delegate = self
        friendsTableView.dataSource = self
        friendsTableView.estimatedRowHeight = 70
        friendsTableView.rowHeight = UITableViewAutomaticDimension
        friendsTableView.registerClass(FriendCell.self, forCellReuseIdentifier: "CodePath.Fomo.FriendCell")
        friendsTableView.separatorStyle = UITableViewCellSeparatorStyle.None
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
