//
//  TripViewController.swift
//  Fomo
//
//  Created by Connie Yu on 3/7/16.
//  Copyright © 2016 TeamAwesome. All rights reserved.
//

import UIKit

class TripViewController: UIViewController {
    
    let destinationTitleLabel: UILabel = UILabel.newAutoLayoutView()
    let destinationLabel: UILabel = UILabel.newAutoLayoutView()
    let startTitleLabel: UILabel = UILabel.newAutoLayoutView()
    let startDateLabel: UILabel = UILabel.newAutoLayoutView()
    let startDateButton: UIButton = UIButton.newAutoLayoutView()
    let endTitleLabel: UILabel = UILabel.newAutoLayoutView()
    let endDateLabel: UILabel = UILabel.newAutoLayoutView()
    let endDateButton: UIButton = UIButton.newAutoLayoutView()
    let doneButton: UIButton = UIButton.newAutoLayoutView()
    
    var didSetupConstraints = false

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavigationBar()
        updateViewConstraints()
    }

    func setUpNavigationBar() {
        self.navigationController?.navigationBarHidden = true
    }
    
    override func loadView() {
        view = UIView()
        
        view.backgroundColor = UIColor.grayColor()
        
        destinationTitleLabel.text = "Destination"
        destinationLabel.text = "Seoul"
        startTitleLabel.text = "Start"
        endTitleLabel.text = "End"
        
        startDateLabel.text = "None"
        
        startDateButton.setImage(UIImage(named: "Calendar"), forState: .Normal)
        startDateButton.addTarget(self, action: "setStartDate", forControlEvents: .TouchUpInside)
        
        endDateLabel.text = "None"
        
        endDateButton.setImage(UIImage(named: "Calendar"), forState: .Normal)
        endDateButton.addTarget(self, action: "setStartDate", forControlEvents: .TouchUpInside)
        
        doneButton.setTitle("Create Trip", forState: .Normal)
        doneButton.addTarget(self, action: "updateTrip", forControlEvents: .TouchUpInside)
        doneButton.backgroundColor = UIColor.greenColor()
        
        view.addSubview(destinationTitleLabel)
        view.addSubview(destinationLabel)
        view.addSubview(startTitleLabel)
        view.addSubview(startDateLabel)
        view.addSubview(startDateButton)
        view.addSubview(endTitleLabel)
        view.addSubview(endDateLabel)
        view.addSubview(endDateButton)
        view.addSubview(doneButton)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        if (!didSetupConstraints) {
            destinationTitleLabel.autoPinEdgeToSuperviewEdge(.Top, withInset: 100)
            destinationTitleLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: 10)
            
            destinationLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: 10)
            destinationLabel.autoAlignAxis(.Horizontal, toSameAxisOfView: destinationTitleLabel)
            
            startTitleLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: 10)
            startTitleLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: destinationTitleLabel, withOffset: 25)
            
            startDateLabel.autoAlignAxis(.Horizontal, toSameAxisOfView: startTitleLabel)
            startDateLabel.autoPinEdge(.Right, toEdge: .Left, ofView: startDateButton, withOffset: -10)
            
            startDateButton.autoSetDimensionsToSize(CGSize(width: 25, height: 25))
            startDateButton.autoAlignAxis(.Horizontal, toSameAxisOfView: startTitleLabel)
            startDateButton.autoPinEdgeToSuperviewEdge(.Right, withInset: 10)
            
            endTitleLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: 10)
            endTitleLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: startTitleLabel, withOffset: 25)
            
            endDateLabel.autoAlignAxis(.Horizontal, toSameAxisOfView: endTitleLabel)
            endDateLabel.autoPinEdge(.Right, toEdge: .Left, ofView: endDateButton, withOffset: -10)
            
            endDateButton.autoSetDimensionsToSize(CGSize(width: 25, height: 25))
            endDateButton.autoAlignAxis(.Horizontal, toSameAxisOfView: endTitleLabel)
            endDateButton.autoPinEdgeToSuperviewEdge(.Right, withInset: 10)
            
            doneButton.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 10)
            doneButton.autoAlignAxisToSuperviewAxis(.Vertical)
            
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
    
    func setStartDate() {
        startDateLabel.text = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .ShortStyle, timeStyle: .NoStyle)
    }
    
    func setEndDate() {
        endDateLabel.text = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .ShortStyle, timeStyle: .NoStyle)
    }
    
    func updateTrip() {
        
    }
}
