//
// TripViewController.swift
// ============================


import UIKit
import EPCalendarPicker

class TripViewController: UIViewController, EPCalendarPickerDelegate {
    
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
    
    var city: City?
    var selectingStartDate = false
    var startDate: NSDate?
    var endDate: NSDate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBar()
        updateViewConstraints()
    }
    
    func setUpNavigationBar() {
        navigationItem.title = "Create Trip"
    }
    
    override func loadView() {
        view = UIView()
        
        view.backgroundColor = UIColor.fomoWhite()
        
        destinationTitleLabel.text = "Destination"
        destinationLabel.text = "Seoul"
        startTitleLabel.text = "Start"
        endTitleLabel.text = "End"
        
        startDateLabel.text = "None"
        
        startDateButton.setImage(UIImage(named: "Calendar"), forState: .Normal)
        startDateButton.addTarget(self, action: "setStartDate", forControlEvents: .TouchUpInside)
        
        endDateLabel.text = "None"
        
        endDateButton.setImage(UIImage(named: "Calendar"), forState: .Normal)
        endDateButton.addTarget(self, action: "setEndDate", forControlEvents: .TouchUpInside)
        
        doneButton.setTitle("Create Trip", forState: .Normal)
        doneButton.addTarget(self, action: "updateTrip", forControlEvents: .TouchUpInside)
        doneButton.backgroundColor = UIColor.fomoBlue()
        doneButton.layer.cornerRadius = 5
        
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
            destinationTitleLabel.autoPinToTopLayoutGuideOfViewController(self, withInset: 20)
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
            
            doneButton.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 30)
            doneButton.autoAlignAxisToSuperviewAxis(.Vertical)
            doneButton.contentEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 10)

            
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
    
    func setStartDate() {
        selectingStartDate = true
        presentCalendar(startDate)
    }
    
    func setEndDate() {
        selectingStartDate = false
        presentCalendar(endDate)
    }
    
    func presentCalendar(date: NSDate?) {
        var dateArray: [NSDate] = []
        if let date = date {
            dateArray.append(date)
        }
        
        let calendarPicker = EPCalendarPicker(startYear: 2016, endYear: 2017, multiSelection: false, selectedDates: dateArray)
        calendarPicker.weekdayTintColor = UIColor.blackColor()
        calendarPicker.weekendTintColor = UIColor.redColor()
        calendarPicker.hightlightsToday = false
        calendarPicker.calendarDelegate = self
        let navigationController = UINavigationController(rootViewController: calendarPicker)
        self.presentViewController(navigationController, animated: true, completion: nil)
    }
    
    func updateTrip() {
        // TODO
        displayTodo("Create trip")
    }
    
    func epCalendarPicker(_: EPCalendarPicker, didSelectDate date : NSDate) {
        if selectingStartDate {
            startDate = date
            startDateLabel.text = NSDateFormatter.localizedStringFromDate(date, dateStyle: .ShortStyle, timeStyle: .NoStyle)
        } else {
            endDate = date
            endDateLabel.text = NSDateFormatter.localizedStringFromDate(date, dateStyle: .ShortStyle, timeStyle: .NoStyle)
        }
    }
    
    func epCalendarPicker(_: EPCalendarPicker, didCancel error : NSError) {}
    

    func displayTodo(todo: String) {
        let alertController = UIAlertController(title: "Fomo", message:"TODO: \(todo)", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        presentViewController(alertController, animated: true, completion: nil)
    }

}