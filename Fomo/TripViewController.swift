//
// TripViewController.swift
// ============================


import UIKit
import EPCalendarPicker


class TripViewController: UIViewController, EPCalendarPickerDelegate {
    
    let cityImageViewContainer: UIView = UIView.newAutoLayoutView()
    let cityImageView: UIImageView = UIImageView.newAutoLayoutView()
    let destinationTitleLabel: UILabel = UILabel.newAutoLayoutView()
    let destinationLabel: UILabel = UILabel.newAutoLayoutView()
    let startTitleLabel: UILabel = UILabel.newAutoLayoutView()
    let startDateLabel: UILabel = UILabel.newAutoLayoutView()
    let startDateButton: UIButton = UIButton.newAutoLayoutView()
    let endTitleLabel: UILabel = UILabel.newAutoLayoutView()
    let endDateLabel: UILabel = UILabel.newAutoLayoutView()
    let endDateButton: UIButton = UIButton.newAutoLayoutView()
    let doneButton: UIButton = UIButton.newAutoLayoutView()
    let iconHighlighted: UIImageView = UIImageView.newAutoLayoutView()
    
    var didSetupConstraints = false
    
    var city: City?
    var selectingStartDate = false
    var startDate: NSDate?
    var endDate: NSDate?
    
    let spinner = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBar()
        updateViewConstraints()
    }
    
    func setUpNavigationBar() {
        self.title = "Create Trip"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }
    
    override func loadView() {
        view = UIView()
        
        view.backgroundColor = UIColor.fomoBackground()
        
        cityImageView.image = City.getCoverPhoto(city!.name!)
        
        destinationTitleLabel.font = UIFont.fomoH2()
        destinationLabel.font = UIFont.fomoH2()
        startTitleLabel.font = UIFont.fomoH2()
        startDateLabel.font = UIFont.fomoH2()
        endTitleLabel.font = UIFont.fomoH2()
        endDateLabel.font = UIFont.fomoH2()
        doneButton.titleLabel?.font = UIFont.fomoH2()
        
        destinationTitleLabel.text = "Destination"
        destinationLabel.text = city!.name
        startTitleLabel.text = "Start"
        startDateLabel.text = "__ / __ / __"
        endTitleLabel.text = "End"
        endDateLabel.text = "__ / __ / __"
                
        iconHighlighted.image = UIImage(named: "calendar")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        iconHighlighted.tintColor = UIColor.fomoHighlight()
        
        startDateButton.setImage(UIImage(named: "calendar"), forState: .Normal)
        startDateButton.setImage(iconHighlighted.image, forState: .Highlighted)
        startDateButton.addTarget(self, action: "setStartDate", forControlEvents: .TouchUpInside)
        
        endDateButton.setImage(UIImage(named: "calendar"), forState: .Normal)
        endDateButton.setImage(iconHighlighted.image, forState: .Highlighted)
        endDateButton.addTarget(self, action: "setEndDate", forControlEvents: .TouchUpInside)
        
        doneButton.setTitle("Create Trip", forState: .Normal)
        doneButton.addTarget(self, action: "createTrip", forControlEvents: .TouchUpInside)
        doneButton.addTarget(self, action: "buttonPress", forControlEvents: .TouchDown)

        doneButton.backgroundColor = UIColor.fomoHighlight()
        doneButton.layer.cornerRadius = 5
        
        view.addSubview(cityImageViewContainer)
        cityImageViewContainer.addSubview(cityImageView)
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
            
            cityImageViewContainer.autoPinToTopLayoutGuideOfViewController(self, withInset: 0)
            cityImageViewContainer.autoPinEdgeToSuperviewEdge(.Left)
            cityImageViewContainer.autoPinEdgeToSuperviewEdge(.Right)
            cityImageViewContainer.autoSetDimension(.Height, toSize: 200)
            cityImageViewContainer.clipsToBounds = true
            
            cityImageView.autoPinEdgesToSuperviewEdges()
            
            destinationTitleLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: cityImageViewContainer, withOffset: 40)
            destinationTitleLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: 20)
            
            destinationLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: 20)
            destinationLabel.autoAlignAxis(.Horizontal, toSameAxisOfView: destinationTitleLabel)
            
            startTitleLabel.autoConstrainAttribute(.Left, toAttribute: .Left, ofView: destinationTitleLabel)
            startTitleLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: destinationTitleLabel, withOffset: 30)
            
            startDateLabel.autoAlignAxis(.Horizontal, toSameAxisOfView: startTitleLabel)
            startDateLabel.autoPinEdge(.Right, toEdge: .Left, ofView: startDateButton, withOffset: -20)
            
            startDateButton.autoSetDimensionsToSize(CGSize(width: 25, height: 25))
            startDateButton.autoAlignAxis(.Horizontal, toSameAxisOfView: startDateLabel)
            startDateButton.autoConstrainAttribute(.Right, toAttribute: .Right, ofView: destinationLabel)
            
            endTitleLabel.autoConstrainAttribute(.Left, toAttribute: .Left, ofView: destinationTitleLabel)
            endTitleLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: startTitleLabel, withOffset: 30)
            
            endDateLabel.autoAlignAxis(.Horizontal, toSameAxisOfView: endTitleLabel)
            endDateLabel.autoConstrainAttribute(.Right, toAttribute: .Right, ofView: startDateLabel)
            
            endDateButton.autoSetDimensionsToSize(CGSize(width: 25, height: 25))
            endDateButton.autoAlignAxis(.Horizontal, toSameAxisOfView: endTitleLabel)
            endDateButton.autoConstrainAttribute(.Right, toAttribute: .Right, ofView: destinationLabel)

            doneButton.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 50)
            doneButton.autoAlignAxisToSuperviewAxis(.Vertical)
            doneButton.contentEdgeInsets = UIEdgeInsetsMake(10, 15, 10, 15)
            
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
        calendarPicker.weekendTintColor = UIColor.blackColor()
        calendarPicker.monthTitleColor = UIColor.fomoBlue()
        calendarPicker.backgroundColor = UIColor.fomoWhite()
        calendarPicker.hightlightsToday = false
        calendarPicker.calendarDelegate = self
        let navigationController = UINavigationController(rootViewController: calendarPicker)
        self.presentViewController(navigationController, animated: true, completion: nil)
    }
    
    func buttonPress() {
        doneButton.transform = CGAffineTransformMakeScale(1.1, 1.1);
    }
    
    func createTrip() {
        showActivityIndicator()
        doneButton.transform = CGAffineTransformIdentity

        let itinerary = Itinerary()
        itinerary.id = String(NSDate().timeIntervalSince1970)
        itinerary.creator = Cache.currentUser
        itinerary.city = city!
        itinerary.tripName = city!.name
        itinerary.startDate = startDate
        
        let numDays = Int((endDate!.timeIntervalSinceDate(startDate!)) / (60 * 60 * 24))
        itinerary.numDays = numDays
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        if appDelegate.ITINERARY_USE_CACHE, let itinerary = Cache.itinerary {
            let fomoNavVC = self.navigationController! as UINavigationController
            fomoNavVC.popToRootViewControllerAnimated(false)
            let container = fomoNavVC.topViewController as! ContainerViewController
            container.itineraryVC.isNewTrip = true
            container.itineraryVC.itinerary = itinerary
            container.onTripPressed(self)
        } else {
            print("Starting to create itinerary...")
            let hud = displayHUD(self.view)
            hud.showAnimated(true)
            
            itinerary.createItinerary { (response: Itinerary?, error: NSError?) -> () in
                if let itinerary = response {     
                    // Repopulate since we lose this when hitting server
                    itinerary.startDate = self.startDate
                    itinerary.endDate = self.endDate
                    itinerary.creator = Cache.currentUser
                    itinerary.numDays = numDays
                    itinerary.city = self.city
                    itinerary.coverPhoto = self.city?.coverPhoto
                    Cache.itinerary = itinerary
                    
                    let fomoNavVC = self.navigationController! as UINavigationController
                    fomoNavVC.popToRootViewControllerAnimated(false)
                    let container = fomoNavVC.topViewController as! ContainerViewController
                    container.itineraryVC.isNewTrip = true
                    container.itineraryVC.itinerary = itinerary
                    container.onTripPressed(self)
                } else {
                    print("Couldn't make itinerary \(error)")
                }
                hud.hide()
                print("Done creating itinerary.")
            }
        }
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
    

    func showActivityIndicator() {
        spinner.activityIndicatorViewStyle = .WhiteLarge
        spinner.color = UIColor.fomoHighlight()
        spinner.center = CGPointMake(self.view.center.x, self.doneButton.center.y - 100)
        spinner.hidesWhenStopped = true
        doneButton.setTitle("Generating Itinerary", forState: .Normal)
        view.addSubview(spinner)
        spinner.startAnimating()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animateWithDuration(15, delay:0, options: [.Repeat, .Autoreverse], animations: {
            self.cityImageView.transform = CGAffineTransformMakeScale(1.5, 1.5)
        }, completion: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        spinner.stopAnimating()
        doneButton.setTitle("Create Trip", forState: .Normal)
        UIView.animateWithDuration(5) { () -> Void in
            self.cityImageView.transform = CGAffineTransformIdentity
        }
    }
}