//
//  AttractionViewController.swift
//  Fomo
//
//  Created by Connie Yu on 3/7/16.
//  Copyright © 2016 TeamAwesome. All rights reserved.
//

import UIKit
import PureLayout

class AttractionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let overviewView: AttractionOverviewView = AttractionOverviewView.newAutoLayoutView()
    let reviewView: UITableView = UITableView.newAutoLayoutView()
    let locationView: AttractionLocationView = AttractionLocationView.newAutoLayoutView()
    var didSetupConstraints = false
    
    let attraction: Attraction = Attraction.generateTestInstance(City.generateTestInstance())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpOverviewView()
        setUpReviewTableView()
        setUpLocationView()
        setUpNavigationBar()
    }
    
    override func loadView() {
        view = UIView()
        view.addSubview(overviewView)
        view.addSubview(reviewView)
        view.addSubview(locationView)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        if (!didSetupConstraints) {
            overviewView.autoPinEdgesToSuperviewEdges()
            reviewView.autoPinEdgesToSuperviewEdges()
            locationView.autoPinEdgesToSuperviewEdges()
            
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
    
    // Overview
    func setUpOverviewView() {
        
    }
    
    // Review
    func setUpReviewTableView() {
        reviewView.delegate = self
        reviewView.dataSource = self
        reviewView.registerClass(ReviewCell.self, forCellReuseIdentifier: "CodePath.Fomo.ReviewCell")
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
        cell.rating.text = "\(attraction.reviews![indexPath.row].rating)"
        cell.date.text = NSDateFormatter.localizedStringFromDate(attraction.reviews![indexPath.row].createdAt! ?? NSDate(), dateStyle: .ShortStyle, timeStyle: .NoStyle)
    }
    
    // Location
    func setUpLocationView() {
    }


    func setUpNavigationBar() {
        let menu = ["Overview", "Reviews", "Map"]
        let segmentedControl = UISegmentedControl(items: menu)
        segmentedControl.tintColor = UIColor.blackColor()
        self.navigationItem.titleView = segmentedControl
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: "indexChanged:", forControlEvents: .ValueChanged)

    }

    func indexChanged(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex
        {
        case 0:
            overviewView.hidden = false
            reviewView.hidden = true
            locationView.hidden = true
        case 1:
            overviewView.hidden = true
            reviewView.hidden = false
            locationView.hidden = true
        case 2:
            overviewView.hidden = true
            reviewView.hidden = true
            locationView.hidden = false
        default:
            break; 
        }
    }
}
