//
// AttractionViewController.swift
// ==============================
// ** DEPRECATED **


import UIKit


class AttractionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var segmentedControl: UISegmentedControl = UISegmentedControl.newAutoLayoutView()
    let overviewView: AttractionOverviewView = AttractionOverviewView.newAutoLayoutView()
    let reviewTableView: UITableView = UITableView.newAutoLayoutView()
    let locationView: AttractionLocationView = AttractionLocationView.newAutoLayoutView()
    
    var didSetupConstraints = false
    
    let attraction: Attraction = Attraction.generateTestInstance(City.generateTestInstance())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSegmentedControl()
        setUpOverviewView()
        setUpReviewTableView()
        setUpLocationView()
    }
    
    override func loadView() {
        view = UIView()
        view.addSubview(overviewView)
        view.addSubview(reviewTableView)
        view.addSubview(locationView)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        if (!didSetupConstraints) {
            segmentedControl.autoPinToTopLayoutGuideOfViewController(self, withInset: 0)
            segmentedControl.autoPinEdgeToSuperviewEdge(.Left)
            segmentedControl.autoPinEdgeToSuperviewEdge(.Right)
            segmentedControl.autoSetDimension(.Height, toSize: 50)
            
            overviewView.autoPinEdge(.Top, toEdge: .Bottom, ofView: segmentedControl)
            overviewView.autoPinEdgeToSuperviewEdge(.Left)
            overviewView.autoPinEdgeToSuperviewEdge(.Right)
            overviewView.autoPinEdgeToSuperviewEdge(.Bottom)
            
            reviewTableView.autoPinEdge(.Top, toEdge: .Bottom, ofView: segmentedControl)
            reviewTableView.autoPinEdgeToSuperviewEdge(.Left)
            reviewTableView.autoPinEdgeToSuperviewEdge(.Right)
            reviewTableView.autoPinEdgeToSuperviewEdge(.Bottom)

            locationView.autoPinEdge(.Top, toEdge: .Bottom, ofView: segmentedControl)
            locationView.autoPinEdgeToSuperviewEdge(.Left)
            locationView.autoPinEdgeToSuperviewEdge(.Right)
            locationView.autoPinEdgeToSuperviewEdge(.Bottom)

            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
    
    
    func setUpSegmentedControl() {
        let menu = ["Overview", "Reviews", "Map"]
        segmentedControl = UISegmentedControl(items: menu)
        segmentedControl.tintColor = UIColor.blackColor()
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: "indexChanged:", forControlEvents: .ValueChanged)
    }
    
    // Overview
    func setUpOverviewView() {
        
    }
    
    // Review
    func setUpReviewTableView() {
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        reviewTableView.rowHeight = UITableViewAutomaticDimension
        reviewTableView.estimatedRowHeight = 100
        reviewTableView.registerClass(ReviewCell.self, forCellReuseIdentifier: "CodePath.Fomo.ReviewCell")
        reviewTableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attraction.reviews!.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CodePath.Fomo.ReviewCell", forIndexPath: indexPath) as! ReviewCell
        configureReviewCell(cell, indexPath: indexPath)
        return cell
    }
    
    func configureReviewCell(cell: ReviewCell, indexPath: NSIndexPath) {
        cell.message.text = attraction.reviews![indexPath.row].message
        cell.rating.text = "\(attraction.reviews![indexPath.row].rating!)"
        cell.date.text = NSDateFormatter.localizedStringFromDate(attraction.reviews![indexPath.row].createdAt! ?? NSDate(), dateStyle: .ShortStyle, timeStyle: .NoStyle)
    }
        
    // Map
    func setUpLocationView() {
    }

    func indexChanged(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex
        {
        case 0:
            overviewView.hidden = false
            reviewTableView.hidden = true
            locationView.hidden = true
        case 1:
            overviewView.hidden = true
            reviewTableView.hidden = false
            locationView.hidden = true
        case 2:
            overviewView.hidden = true
            reviewTableView.hidden = true
            locationView.hidden = false
        default:
            break; 
        }
    }
}
