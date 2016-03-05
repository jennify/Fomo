//
//  TripItineraryViewController.swift
//  Fomo
//
//  Created by Jennifer Lee on 2/28/16.
//  Copyright © 2016 TeamAwesome. All rights reserved.
//

import UIKit
import PureLayout

class ItineraryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var travellersView: UIView!
    var tripDetailsView: UIView!
    var calendarView: UIView!
    var itineraryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        setUpTableView()
        
        updateViewConstraints()
    }
    
    func setUpViews() {
        travellersView = UIView()
        tripDetailsView = UIView()
        calendarView = UIView()
        itineraryTableView = UITableView()
        
        view.addSubview(itineraryTableView)
    }
    
    override func updateViewConstraints() {
        itineraryTableView.autoPinEdgesToSuperviewEdges()
        
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
