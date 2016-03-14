//
//  TripItineraryViewController.swift
//  Fomo
//
//  Created by Jennifer Lee on 2/28/16.
//  Copyright © 2016 TeamAwesome. All rights reserved.
//

import UIKit
import PureLayout
import FoldingCell

@objc(ItineraryViewController)
class ItineraryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate {

    let travellersView: UIView = TravellersView.newAutoLayoutView()
    let tripDetailsView: UIView = UIView.newAutoLayoutView()
    let itineraryTableView: UITableView = UITableView.newAutoLayoutView()
    let calendarView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        return UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
    }()
    var didSetupConstraints = false
    
    var cellHeights = [[CGFloat]]()
    var kCloseCellHeight: CGFloat = FoldingTripEventCell.topViewHeight + 8 // equal or greater foregroundView height
    let kOpenCellHeight: CGFloat = FoldingTripEventCell.detailsViewHeight + 8 // equal or greater containerView height

    let itinerary: Itinerary = Itinerary.generateTestInstance()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpItineraryTableView()
        setUpCalendarView()
        setUpNavigationBar()

        for dayNum in 0...itinerary.days!.count-1 {
            cellHeights.append([CGFloat]())
            for _ in 0...itinerary.days![dayNum].tripEvents!.count-1 {
                cellHeights[dayNum].append(kCloseCellHeight)
            }
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if cell is FoldingTripEventCell {
            let foldingCell = cell as! FoldingTripEventCell
            
            if cellHeights[indexPath.section][indexPath.row] == kCloseCellHeight {
                foldingCell.selectedAnimation(false, animated: false, completion:nil)
            } else {
                foldingCell.selectedAnimation(true, animated: false, completion: nil)
            }
        }
    }
    
    override func loadView() {
        view = UIView()

        tripDetailsView.backgroundColor = UIColor.fomoSand()
        calendarView.backgroundColor = UIColor.fomoBlue()

        view.addSubview(travellersView)
        view.addSubview(tripDetailsView)
        view.addSubview(calendarView)
        view.addSubview(itineraryTableView)

        view.setNeedsUpdateConstraints()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return cellHeights[indexPath.section][indexPath.row]
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
            itineraryTableView.estimatedRowHeight = 100
            itineraryTableView.rowHeight = UITableViewAutomaticDimension
            
            didSetupConstraints = true
        }

        super.updateViewConstraints()
    }

    func setUpNavigationBar() {
        self.navigationController?.navigationBarHidden = true
        navigationItem.title = "Itinerary"
    }

    //# MARK: Itinerary Methods

    func setUpItineraryTableView() {
        itineraryTableView.delegate = self
        itineraryTableView.dataSource = self
        itineraryTableView.registerClass(TripEventCell.self, forCellReuseIdentifier: "CodePath.Fomo.TripEventCell")
        itineraryTableView.registerClass(DayHeaderCell.self, forHeaderFooterViewReuseIdentifier: "CodePath.Fomo.DayHeaderCell")
        itineraryTableView.registerClass(FoldingTripEventCell.self, forCellReuseIdentifier: "CodePath.Fomo.FoldingTripEventCell")
        itineraryTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return itinerary.numberDays()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itinerary.days![section].tripEvents!.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CodePath.Fomo.FoldingTripEventCell", forIndexPath: indexPath) as! FoldingTripEventCell
        cell.awakeFromNib()
        cellHeights[indexPath.section][indexPath.row] = self.kCloseCellHeight
        print(itinerary.days![indexPath.section].tripEvents![indexPath.row].attraction?.name)
        cell.attraction = itinerary.days![indexPath.section].tripEvents![indexPath.row].attraction
        return cell
    }

    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableHeaderFooterViewWithIdentifier("CodePath.Fomo.DayHeaderCell") as! DayHeaderCell
        configureHeaderCell(cell, section: section)
        return cell
    }

    func configureHeaderCell(cell: DayHeaderCell, section: Int) {
        cell.dayName.text = "DAY \(section + 1)"
        cell.dayName.font = UIFont(name: "AppleSDGothicNeo-Thin", size: 20)
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        itineraryTableView.deselectRowAtIndexPath(indexPath, animated: true)
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! FoldingTripEventCell
        
        var duration = 0.0
        if cellHeights[indexPath.section][indexPath.row] == kCloseCellHeight { // open cell
            cellHeights[indexPath.section][indexPath.row] = kOpenCellHeight
            cell.selectedAnimation(true, animated: true, completion: nil)
            duration = 0.4
        } else {// close cell
            cellHeights[indexPath.section][indexPath.row] = kCloseCellHeight
            cell.selectedAnimation(false, animated: true, completion: nil)
            duration = 0.7
            
        }

        UIView.animateWithDuration(duration, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion:nil)
        
    }

    //# MARK: Calendar Methods

    func setUpCalendarView() {
        calendarView.delegate = self
        calendarView.dataSource = self
        calendarView.registerClass(DayCell.self, forCellWithReuseIdentifier: "CodePath.Fomo.DayCell")
        calendarView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itinerary.numberDays() + 1
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CodePath.Fomo.DayCell", forIndexPath: indexPath) as! DayCell
        configureDayCell(cell, indexPath: indexPath)
        return cell
    }

    func configureDayCell(cell: DayCell, indexPath: NSIndexPath) {
        let numberDays = itinerary.numberDays()
        if indexPath.row < numberDays {
            cell.dayName.text = "Day \(indexPath.row + 1)"
        } else {
            cell.dayName.text = "+"
        }
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row < itinerary.numberDays() {
            itineraryTableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: true)
        } else {
            displayTodo("Add a day")
        }
    }

    func displayTodo(todo: String) {
        let alertController = UIAlertController(title: "Fomo", message:"TODO: \(todo)", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        presentViewController(alertController, animated: true, completion: nil)
    }
}
