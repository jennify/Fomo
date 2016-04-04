//
//  FoldingTripEventCell.swift
// ============================


import UIKit
import FoldingCell


class FoldingTripEventCell: FoldingCell {
    var tripEvent: TripEvent?
    var attraction: Attraction?
    var parentView: UIView?
    var didSetupConstraints = false
    
    let topView: TopView = TopView.newAutoLayoutView()
    let detailsView: UIView = UIView.newAutoLayoutView()
    
    var didAwake = false
    var detailSegments: [UIView] = []
    
    let locationView: UIImageView = UIImageView.newAutoLayoutView()
    let likeButton: UIButton = UIButton.newAutoLayoutView()
    let dislikeButton: UIButton = UIButton.newAutoLayoutView()
    let neutralButton: UIButton = UIButton.newAutoLayoutView()
    
    var detailsAttractionName : UILabel = UILabel.newAutoLayoutView()
    var addressLabel: UILabel = UILabel.newAutoLayoutView()
    
    var ratingView: UIView = UIView.newAutoLayoutView()
    var ratingLabel: UILabel = UILabel.newAutoLayoutView()
    var typeLabel: UILabel = UILabel.newAutoLayoutView()
    
    var numRatingsLabel: UILabel = UILabel.newAutoLayoutView()
    var websiteLabel: UILabel = UILabel.newAutoLayoutView()
    var phoneNumber: UILabel = UILabel.newAutoLayoutView()
    var hoursLabel: UILabel = UILabel.newAutoLayoutView()
    
    var likeLabel: UILabel = UILabel.newAutoLayoutView()
    var likeVotersView: TravellersView = TravellersView.newAutoLayoutView()
    
    class var topViewHeight: CGFloat {
        get {
            return 100
        }
    }
    
    class var detailsViewHeight: CGFloat {
        get {
            return 420
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initViews()
        updateConstraints()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initViews()
        updateConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        initViews()
        updateConstraints()
    }
    
    override func updateConstraints() {
        if !self.didSetupConstraints {
            let width = UIScreen.mainScreen().bounds.width - 16
            topView.autoPinEdgeToSuperviewEdge(.Leading, withInset: 8)
            topView.autoSetDimension(.Height, toSize: FoldingTripEventCell.topViewHeight)
            topView.autoSetDimension(.Width, toSize: width)
            self.topView.autoPinEdgeToSuperviewEdge(.Top, withInset: 8).autoIdentify("ForegroundViewTop")
            
            detailsView.autoPinEdgeToSuperviewEdge(.Leading, withInset: 8)
            detailsView.autoSetDimension(.Width, toSize: width)
            detailsView.autoSetDimension(.Height, toSize: FoldingTripEventCell.detailsViewHeight)
            self.detailsView.autoPinEdgeToSuperviewEdge(.Top, withInset: 8).autoIdentify("ContainerViewTop")
            
            for i in 0...self.itemCount-1 {
                let view = self.detailSegments[i]
                view.autoPinEdgeToSuperviewEdge(.Leading, withInset: 0)
                view.autoPinEdgeToSuperviewEdge(.Trailing, withInset: 0)
                let picHeight = FoldingTripEventCell.topViewHeight*2
                var segHeight = (FoldingTripEventCell.detailsViewHeight-picHeight)/CGFloat(self.detailSegments.count-1)
                
                if i == 0 {
                    segHeight = picHeight
                }
                view.autoSetDimension(.Height, toSize: segHeight)
                
                var topEdge = (segHeight * CGFloat(i-1)) + picHeight
                if i == 0{
                    topEdge = 0
                }
                
                view.autoPinEdgeToSuperviewEdge(.Top, withInset: topEdge)
            }
            
            // Set up locationView
            locationView.autoPinEdgesToSuperviewEdges()
            
            // Set up decision seg
//            neutralButton.autoCenterInSuperview()
//            dislikeButton.autoAlignAxisToSuperviewMarginAxis(.Horizontal)
//            dislikeButton.autoAlignAxis(.Vertical, toSameAxisOfView: dislikeButton.superview!, withMultiplier: 0.5)
//            likeButton.autoAlignAxisToSuperviewMarginAxis(.Horizontal)
//            likeButton.autoAlignAxis(.Vertical, toSameAxisOfView: dislikeButton.superview!, withMultiplier: 1.5)
            
            // Set up details view
            detailsAttractionName.autoPinEdgeToSuperviewEdge(.Leading, withInset: 8)
            detailsAttractionName.autoPinEdgeToSuperviewEdge(.Top, withInset: 8)
            detailsAttractionName.autoPinEdge(.Trailing, toEdge: .Leading, ofView: ratingView, withOffset: 8)
            
            addressLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: detailsAttractionName, withOffset: 4)
            addressLabel.autoPinEdge(.Leading, toEdge: .Leading, ofView: detailsAttractionName)
            addressLabel.autoPinEdge(.Trailing, toEdge: .Leading, ofView: ratingView, withOffset: 8)
            
            typeLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: addressLabel, withOffset: 4)
            typeLabel.autoPinEdge(.Leading, toEdge: .Leading, ofView: detailsAttractionName)
            typeLabel.autoPinEdge(.Trailing, toEdge: .Leading, ofView: ratingView, withOffset: 8)
            
            likeLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: typeLabel, withOffset: 4)
            likeLabel.autoPinEdge(.Leading, toEdge: .Leading, ofView: typeLabel)
            
            likeVotersView.autoPinEdge(.Leading, toEdge: .Trailing, ofView: likeLabel, withOffset: 8)
            likeVotersView.autoPinEdge(.Top, toEdge: .Top, ofView: typeLabel, withOffset: 16)
            likeVotersView.autoPinEdgeToSuperviewEdge(.Trailing, withInset: 8)
            likeVotersView.autoSetDimension(.Height, toSize: likeVotersView.faceHeight)
            
            websiteLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: likeVotersView, withOffset: 4)
            websiteLabel.autoPinEdge(.Leading, toEdge: .Leading, ofView: detailsAttractionName)
            websiteLabel.autoPinEdge(.Trailing, toEdge: .Leading, ofView: ratingView, withOffset: 8)
            
            phoneNumber.autoPinEdge(.Top, toEdge: .Bottom, ofView: websiteLabel, withOffset: 4)
            phoneNumber.autoPinEdge(.Leading, toEdge: .Leading, ofView: detailsAttractionName)
            phoneNumber.autoPinEdge(.Trailing, toEdge: .Leading, ofView: ratingView, withOffset: 8)
//            phoneNumber.autoSetDimension(.Height, toSize: 20)
            
            hoursLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: phoneNumber, withOffset: 4)
            hoursLabel.autoPinEdge(.Leading, toEdge: .Leading, ofView: detailsAttractionName)
            hoursLabel.autoPinEdge(.Trailing, toEdge: .Leading, ofView: ratingView, withOffset: 8)
            
            // Setup ratings
            ratingLabel.autoCenterInSuperview()
            ratingView.autoPinEdgeToSuperviewEdge(.Top, withInset: 8)
            ratingView.autoPinEdgeToSuperviewEdge(.Trailing, withInset: 8)
            ratingView.autoSetDimension(.Width, toSize: 40)
            ratingView.autoSetDimension(.Height, toSize: 40)
            numRatingsLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: ratingView, withOffset: 8)
            numRatingsLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: 8)
            
            
            

            
            didSetupConstraints = true
        }
        super.updateConstraints()
    }
    
    func initViews() {

        self.itemCount = detailSegments.count
        initTopView()
        
        detailsView.backgroundColor = UIColor.fomoCardBG().colorWithAlphaComponent(0.8)
        detailsView.layer.cornerRadius = 10
        detailsView.layer.masksToBounds = true
        self.contentView.addSubview(topView)
        self.contentView.addSubview(detailsView)
        
        foregroundView = self.topView
        containerView = self.detailsView
        self.topView.initViews()
        
        self.backViewColor = UIColor.fomoHamburgerBGColor()
        self.itemCount = 4
        
        for _ in 0...self.itemCount-1 {
            self.detailSegments.append(UIView.newAutoLayoutView())
        }
        for view in detailSegments {
            detailsView.addSubview(view)
        }
        
        initPicSeg()
        initDetailsView()
        initDecisionSeg()
        
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: "didRightSwipe:")
        swipeRightGesture.direction = UISwipeGestureRecognizerDirection.Right
        self.contentView.addGestureRecognizer(swipeRightGesture)
        
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: "didLeftSwipe:")
        swipeLeftGesture.direction = UISwipeGestureRecognizerDirection.Left
        self.contentView.addGestureRecognizer(swipeLeftGesture)
        

        
    }
    
    func initTopView() {
        topView.backgroundColor = UIColor.fomoCardBG()
        topView.layer.cornerRadius = 10
        topView.layer.masksToBounds = true
        topView.attraction = attraction
        topView.tripEvent = tripEvent
    }
    
    func initDetailsView() {
        let detSeg = detailSegments[1]
        detailsAttractionName.text = attraction?.name
        detailsAttractionName.font = UIFont.fomoH1()
        detailsAttractionName.numberOfLines = 0
        
        addressLabel.text = attraction?.address
        addressLabel.font = UIFont.fomoParagraph()
        addressLabel.numberOfLines = 0

        
        typeLabel.text = attraction?.getTypeString()
        typeLabel.font = UIFont.fomoParagraph()
        typeLabel.textColor = UIColor.lightGrayColor()
        typeLabel.numberOfLines = 0
        
        if attraction != nil {
            if attraction?.rating == nil {
                ratingLabel.text = "?"
            } else {
                ratingLabel.text = "\(attraction!.rating!)"    
            }
            likeVotersView.setTravellerFaces(self.tripEvent!.likers!)
            
            if attraction?.numReviews != nil {
                numRatingsLabel.text = "\(attraction!.numReviews!) reviews"
            } else {
                numRatingsLabel.text = "No reviews"
            }
            
            if attraction?.website != nil {
                websiteLabel.text = "Website: \(attraction!.website!)"
            } else {
                websiteLabel.text = ""
            }
            
            if attraction?.phoneNumber != nil {
                phoneNumber.text = "Call: \(attraction!.phoneNumber!)"
            } else {
                phoneNumber.text = ""
            }
            
            if attraction!.hoursText?.first != nil {
                hoursLabel.text = "Hours Today: \(attraction!.hoursText!.first!)"
            } else {
                hoursLabel.text = ""
            }
            
            
        }
        ratingLabel.font = UIFont.fomoH2()
        ratingLabel.textColor = UIColor.fomoWhite()
        
        ratingView.backgroundColor = UIColor.fomoHighlight()
        ratingView.layer.cornerRadius = 5
        ratingView.clipsToBounds = true
        
        likeLabel.text = "LIKED BY:"
        likeLabel.font = UIFont.fomoSized(10)
        likeLabel.textColor = UIColor.lightGrayColor()
        likeLabel.sizeToFit()
        likeVotersView.backgroundColor = UIColor.clearColor()
        
        numRatingsLabel.font = UIFont.fomoSized(12)
        numRatingsLabel.textColor = UIColor.darkGrayColor()
        numRatingsLabel.sizeToFit()
        numRatingsLabel.numberOfLines = 0
        
        websiteLabel.font = UIFont.fomoSized(12)
        websiteLabel.textColor = UIColor.darkGrayColor()
        websiteLabel.sizeToFit()
        websiteLabel.numberOfLines = 0

        phoneNumber.textColor = UIColor.darkGrayColor()
        phoneNumber.font = UIFont.fomoSized(12)
        phoneNumber.numberOfLines = 0
        phoneNumber.sizeToFit()
        
        hoursLabel.font = UIFont.fomoSized(12)
        hoursLabel.textColor = UIColor.darkGrayColor()
        hoursLabel.sizeToFit()
        hoursLabel.numberOfLines = 0
        
        detSeg.addSubview(detailsAttractionName)
        detSeg.addSubview(addressLabel)
        detSeg.addSubview(typeLabel)
        detSeg.addSubview(phoneNumber)
        detSeg.addSubview(websiteLabel)
        detSeg.addSubview(hoursLabel)
        
        ratingView.addSubview(ratingLabel)
        detSeg.addSubview(ratingView)
        detSeg.addSubview(numRatingsLabel)
        
        detSeg.addSubview(likeVotersView)
        detSeg.addSubview(likeLabel)

    }
    
    func callPhone() {
        print("Call Phone")
        let busPhone = self.phoneNumber
        if let url = NSURL(string: "tel://\(busPhone)") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    func initPicSeg() {
        let picSeg = detailSegments[0]
        if attraction != nil {
            locationView.contentMode = .ScaleAspectFill
            locationView.clipsToBounds = true
            
            if attraction!.imageUrls.count == 0 {
                locationView.image = UIImage(named: "noImage")
            } else {
                locationView.setImageWithURL(NSURL(string: attraction!.imageUrls.first!)!)
            }
            
        }
        picSeg.addSubview(locationView)
        
    }
    
    func initDecisionSeg() {
    
        likeButton.setImage(UIImage(named: "check"), forState: .Normal)
        dislikeButton.setImage(UIImage(named: "cross"), forState: .Normal)
        neutralButton.setImage(UIImage(named: "star"), forState: .Normal)
        
        likeButton.addTarget(self, action: "onLike", forControlEvents: UIControlEvents.TouchUpInside)
        dislikeButton.addTarget(self, action: "onDislike", forControlEvents: UIControlEvents.TouchUpInside)
        neutralButton.addTarget(self, action: "onNeutral", forControlEvents: UIControlEvents.TouchUpInside)
        
//        decSeg.addSubview(likeButton)
//        decSeg.addSubview(dislikeButton)
//        decSeg.addSubview(neutralButton)
    }
    
    func didLeftSwipe(panGestureRecognizer: UISwipeGestureRecognizer) {
        let point = panGestureRecognizer.locationInView(parentView)
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            print("Gesture began at: \(point)")
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            print("Gesture changed at: \(point)")
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            print("Gesture ended at: \(point)")
        }
        print("Swipe Left")
    }
    
    func didRightSwipe(gesture: UISwipeGestureRecognizer) {
        print("Swipe Right")
    }
    
    func onLike() {
        print("Yay")
    }
    
    func onDislike() {
        print("Oh no")
    }
    
    func onNeutral() {
        print("Very neutral")
    }
    
    override func animationDuration(itemIndex:NSInteger, type:AnimationType)-> NSTimeInterval {
        let durations = [0.3, 0.2, 0.2]
        return durations[itemIndex]
    }

}

class TopView: RotatedView {
    var attractionName: UILabel = UILabel.newAutoLayoutView()
    var imageView: UIImageView = UIImageView.newAutoLayoutView()
    var typeLabel: UILabel = UILabel.newAutoLayoutView()
    var attraction: Attraction?
    var tripEvent: TripEvent?
    var didSetupConstraintsTV = false
    
    var likeLabel: UILabel = UILabel.newAutoLayoutView()
    
    override required init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
        updateConstraints()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initViews()
        updateConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        initViews()
        updateConstraints()
    }
    
    override func updateConstraints() {
        if !didSetupConstraintsTV {
            imageView.autoPinEdgeToSuperviewEdge(.Top)
            imageView.autoPinEdgeToSuperviewEdge(.Bottom)
            imageView.autoPinEdgeToSuperviewEdge(.Leading)
            imageView.autoSetDimension(.Width, toSize: 80)
            imageView.contentMode = .ScaleAspectFill
            
            attractionName.autoPinEdgeToSuperviewEdge(.Top, withInset: 8)
            attractionName.autoPinEdge(.Leading, toEdge: .Trailing, ofView: imageView, withOffset: 8)
            attractionName.autoPinEdgeToSuperviewEdge(.Trailing, withInset: 8, relation: .Equal)
            
            typeLabel.autoPinEdge(.Leading, toEdge: .Leading, ofView: attractionName, withOffset: 0)
            typeLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: attractionName, withOffset: 4)
            typeLabel.autoPinEdgeToSuperviewEdge(.Trailing, withInset: 8)
            
            
            didSetupConstraintsTV = true
        }
        super.updateConstraints()
    }
    
    func initViews() {
        if attraction != nil {
            attractionName.text = attraction?.name
            attractionName.font = UIFont.fomoH2()
            attractionName.numberOfLines = 0
            attractionName.sizeToFit()
            
            if attraction?.imageUrls.count == 0 {
                imageView.image = UIImage(named: "noImage")
            } else {
                imageView.setImageWithURL(NSURL(string: attraction!.imageUrls.first!)!)
            }
            imageView.clipsToBounds = true
            imageView.contentMode = .ScaleAspectFill
    
            typeLabel.text = attraction?.getTypeString()
            typeLabel.font = UIFont.fomoParagraph()
            typeLabel.numberOfLines = 0
            typeLabel.sizeToFit()
            typeLabel.textColor = UIColor.darkGrayColor()
            
            
            likeLabel.text = "LIKED BY"
            likeLabel.sizeToFit()
            likeLabel.font = UIFont.fomoSized(10)
            likeLabel.textColor = UIColor.lightGrayColor()
            
        } else {
            attractionName.text = "Invalid attraction"
        }
        self.addSubview(attractionName)
        self.addSubview(imageView)
        self.addSubview(typeLabel)
    }
    
    
}
