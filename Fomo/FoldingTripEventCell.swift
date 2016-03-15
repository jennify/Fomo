//
//  FoldingTripEventCell.swift
//  Fomo
//
//  Created by Jennifer Lee on 3/13/16.
//  Copyright © 2016 TeamAwesome. All rights reserved.
//

import UIKit
import FoldingCell

class FoldingTripEventCell: FoldingCell {
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
    
    class var topViewHeight: CGFloat {
        get {
            return 100
        }
    }
    
    class var detailsViewHeight: CGFloat {
        get {
            return 380
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
            let width = (parentView?.frame.width ?? 310) - 8
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
            neutralButton.autoCenterInSuperview()
            dislikeButton.autoAlignAxisToSuperviewMarginAxis(.Horizontal)
            dislikeButton.autoAlignAxis(.Vertical, toSameAxisOfView: dislikeButton.superview!, withMultiplier: 0.5)
            likeButton.autoAlignAxisToSuperviewMarginAxis(.Horizontal)
            likeButton.autoAlignAxis(.Vertical, toSameAxisOfView: dislikeButton.superview!, withMultiplier: 1.5)
            
            // Set up details view
            detailsAttractionName.autoPinEdgeToSuperviewEdge(.Leading, withInset: 8)
            detailsAttractionName.autoPinEdgeToSuperviewEdge(.Top, withInset: 8)
            
            didSetupConstraints = true
        }
        super.updateConstraints()
    }
    
    func initViews() {

        self.backgroundColor = UIColor.fomoSand()
        self.itemCount = detailSegments.count
        
        
        initTopView()
        
    
        detailsView.backgroundColor = UIColor.fomoWhite().colorWithAlphaComponent(0.8)
        detailsView.layer.cornerRadius = 10
        detailsView.layer.masksToBounds = true
        self.contentView.addSubview(topView)
        self.contentView.addSubview(detailsView)
        
        foregroundView = self.topView
        containerView = self.detailsView

        
        self.backViewColor = UIColor.fomoBlue()
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
        topView.backgroundColor = UIColor.fomoWhite()
        topView.layer.cornerRadius = 10
        topView.layer.masksToBounds = true
        topView.attraction = attraction
    }
    
    func initDetailsView() {
        let detSeg = detailSegments[1]
        detailsAttractionName.text = attraction?.name
        detailsAttractionName.font = UIFont(name: "AppleSDGothicNeo-Light", size: 20)
        
        detSeg.addSubview(detailsAttractionName)
    }
    
    func initPicSeg() {
        let picSeg = detailSegments[0]
        if attraction != nil {
            locationView.setImageWithURL(NSURL(string: attraction!.imageUrls!.first!)!)
        }
        picSeg.addSubview(locationView)
        
    }
    
    func initDecisionSeg() {
        let decSeg = detailSegments[3]
    
        likeButton.setImage(UIImage(named: "check"), forState: .Normal)
        dislikeButton.setImage(UIImage(named: "cross"), forState: .Normal)
        neutralButton.setImage(UIImage(named: "star"), forState: .Normal)
        
        likeButton.addTarget(self, action: "onLike", forControlEvents: UIControlEvents.TouchUpInside)
        dislikeButton.addTarget(self, action: "onDislike", forControlEvents: UIControlEvents.TouchUpInside)
        neutralButton.addTarget(self, action: "onNeutral", forControlEvents: UIControlEvents.TouchUpInside)
        
        decSeg.addSubview(likeButton)
        decSeg.addSubview(dislikeButton)
        decSeg.addSubview(neutralButton)
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
        let durations = [0.4, 0.4, 0.4]
        return durations[itemIndex]
    }

}

class TopView: RotatedView {
    var attractionName: UILabel = UILabel.newAutoLayoutView()
    var imageView: UIImageView = UIImageView.newAutoLayoutView()
    var attraction: Attraction?
    var didSetupConstraintsTV = false
    
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
            imageView.autoSetDimension(.Width, toSize: 30)
            imageView.contentMode = .ScaleAspectFill
            
            attractionName.autoPinEdgeToSuperviewEdge(.Top, withInset: 8)
            attractionName.autoPinEdge(.Leading, toEdge: .Trailing, ofView: imageView, withOffset: 68)
            
            
            didSetupConstraintsTV = true
        }
        super.updateConstraints()
    }
    
    func initViews() {
        
        
        if attraction != nil {
            attractionName.text = attraction?.name
            attractionName.font = UIFont(name: "AppleSDGothicNeo-Light", size: 17)
            imageView.setImageWithURL(NSURL(string: attraction!.imageUrls!.first!)!)
        } else {
            attractionName.text = "Invalid attraction"
        }
        self.addSubview(attractionName)
        self.addSubview(imageView)
    }
    
    
}

//class TopView: RotatedView {
//    var attractionName: UILabel = UILabel.newAutoLayoutView()
//    var attraction: Attraction?
//    var didSetupConstraints = false
//    
//    override required init(frame: CGRect) {
//        super.init(frame: frame)
//        initViews()
//        updateConstraints()
//    }
//    
//    required init(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)!
//        initViews()
//        updateConstraints()
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        initViews()
//        updateConstraints()
//    }
//    
//    override func updateConstraints() {
//        if {
//            attractionName.autoCenterInSuperview()
//            
//        }
//        super.updateConstraints()
//    }
//    
//    func initViews() {
//        
//    }
//    
//    
//}