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
    
    let tripevent: TripEvent = TripEvent.generateTestInstance(City.generateTestInstance())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpOverviewView()
        setUpReviewTableView()
        setUpLocationView()
    }
    
    override func loadView() {
        view = UIView()
        
        view.backgroundColor = UIColor.whiteColor()

        let menu = ["Overview", "Reviews", "Map"]
        segmentedControl = UISegmentedControl(items: menu)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = UIColor.whiteColor()
        segmentedControl.tintColor = UIColor.fomoBlue()
        segmentedControl.addTarget(self, action: "indexChanged:", forControlEvents: .ValueChanged)
        
        view.addSubview(segmentedControl)
        view.addSubview(overviewView)
        view.addSubview(reviewTableView)
        view.addSubview(locationView)
        
        overviewView.hidden = false
        reviewTableView.hidden = true
        locationView.hidden = true
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        if (!didSetupConstraints) {
            segmentedControl.autoPinToTopLayoutGuideOfViewController(self, withInset: 10)
            segmentedControl.autoPinEdgeToSuperviewEdge(.Left, withInset: 10)
            segmentedControl.autoPinEdgeToSuperviewEdge(.Right, withInset: 10)
            segmentedControl.autoSetDimension(.Height, toSize: 30)
            
            overviewView.autoPinEdge(.Top, toEdge: .Bottom, ofView: segmentedControl, withOffset: 10)
            overviewView.autoPinEdgeToSuperviewEdge(.Left)
            overviewView.autoPinEdgeToSuperviewEdge(.Right)
            overviewView.autoPinEdgeToSuperviewEdge(.Bottom)
            
            reviewTableView.autoPinEdge(.Top, toEdge: .Bottom, ofView: segmentedControl, withOffset: 10)
            reviewTableView.autoPinEdgeToSuperviewEdge(.Left)
            reviewTableView.autoPinEdgeToSuperviewEdge(.Right)
            reviewTableView.autoPinEdgeToSuperviewEdge(.Bottom)

            locationView.autoPinEdge(.Top, toEdge: .Bottom, ofView: segmentedControl, withOffset: 10)
            locationView.autoPinEdgeToSuperviewEdge(.Left)
            locationView.autoPinEdgeToSuperviewEdge(.Right)
            locationView.autoPinEdgeToSuperviewEdge(.Bottom)

            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
    
    // Overview
    func setUpOverviewView() {
        let attraction = tripevent.attraction!
        overviewView.backgroundColor = UIColor.fomoPeriwinkle()
        let attractionImageUrl = NSURL(string: attraction.imageUrls![0])!
        overviewView.imageView.setImageWithURL(attractionImageUrl)
        overviewView.reviewCount.text = "\(attraction.reviews!.count)"
        overviewView.attractionName.text = attraction.name
        overviewView.downvoteCount.text = "\(tripevent.dislikers!.count)"
        overviewView.neutralCount.text = "\(tripevent.neutrals!.count)"
        overviewView.upvoteCount.text = "\(tripevent.likers!.count)"
        overviewView.voteNames.text = "name, name, name"
        overviewView.category.text = "category, category"
        overviewView.attractionDescription.text = "description description description"
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
        return tripevent.attraction!.reviews!.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CodePath.Fomo.ReviewCell", forIndexPath: indexPath) as! ReviewCell
        configureReviewCell(cell, indexPath: indexPath)
        return cell
    }
    
    func configureReviewCell(cell: ReviewCell, indexPath: NSIndexPath) {
        cell.message.text = tripevent.attraction!.reviews![indexPath.row].message
        cell.rating.text = "Rating: \(tripevent.attraction!.reviews![indexPath.row].rating!) stars"
        cell.date.text = NSDateFormatter.localizedStringFromDate(tripevent.attraction!.reviews![indexPath.row].createdAt! ?? NSDate(), dateStyle: .ShortStyle, timeStyle: .NoStyle)
    }
        
    // Map
    func setUpLocationView() {
        locationView.backgroundColor = UIColor.fomoSand()
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
