//
//  TripItineraryViewController.swift
//  Fomo
//
//  Created by Jennifer Lee on 2/28/16.
//  Copyright © 2016 TeamAwesome. All rights reserved.
//

import UIKit
import PureLayout

@objc(ItineraryViewController)
class ItineraryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let travellersView: UIView = UIView.newAutoLayoutView()
    let tripDetailsView: UIView = UIView.newAutoLayoutView()
    let calendarView: UIView = UIView.newAutoLayoutView()
    let itineraryTableView: UITableView = UITableView.newAutoLayoutView()
    
    var didSetupConstraints = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
    }
    
    override func loadView() {
        view = UIView()
        
        travellersView.backgroundColor = UIColor.blueColor()
        tripDetailsView.backgroundColor = UIColor.redColor()
        calendarView.backgroundColor = UIColor.greenColor()
        
        view.addSubview(travellersView)
        view.addSubview(tripDetailsView)
        view.addSubview(calendarView)
        view.addSubview(itineraryTableView)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        if (!didSetupConstraints) {
            travellersView.autoPinEdgeToSuperviewEdge(.Top)
            travellersView.autoSetDimension(.Height, toSize: 70.0)
            travellersView.autoPinEdgeToSuperviewEdge(.Left)
            travellersView.autoPinEdgeToSuperviewEdge(.Right)
            
            tripDetailsView.autoPinEdgeToSuperviewEdge(.Left)
            tripDetailsView.autoPinEdgeToSuperviewEdge(.Right)
            tripDetailsView.autoSetDimension(.Height, toSize: 20.0)
            tripDetailsView.autoPinEdge(.Top, toEdge: .Bottom, ofView: travellersView)
            
            calendarView.autoPinEdgeToSuperviewEdge(.Left)
            calendarView.autoPinEdgeToSuperviewEdge(.Right)
            calendarView.autoSetDimension(.Height, toSize: 70.0)
            calendarView.autoPinEdge(.Top, toEdge: .Bottom, ofView: tripDetailsView)
            
            itineraryTableView.autoPinEdge(.Top, toEdge: .Bottom, ofView: calendarView)
            itineraryTableView.autoPinEdgeToSuperviewEdge(.Left)
            itineraryTableView.autoPinEdgeToSuperviewEdge(.Right)
            itineraryTableView.autoPinEdgeToSuperviewEdge(.Bottom)
            
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
    
    func setUpTableView() {
        itineraryTableView.delegate = self
        itineraryTableView.dataSource = self
        itineraryTableView.registerClass(TripEventCell.self, forCellReuseIdentifier: "CodePath.Fomo.TripEventCell")
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CodePath.Fomo.TripEventCell", forIndexPath: indexPath) as! TripEventCell
        configureCell(cell, forRowAtIndexPath: indexPath)
        return cell
    }
    
    func configureCell(cell: UITableViewCell, forRowAtIndexPath: NSIndexPath) {
        
    }
}
