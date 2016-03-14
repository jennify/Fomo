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
    var didSetupConstraints = false
    
    let topView: ForegroundView = ForegroundView.newAutoLayoutView()
    let detailsView: UIView = UIView.newAutoLayoutView()
    var attractionName: UILabel = UILabel.newAutoLayoutView()
    
    var detailSegments: [UIView] = []
    
    class var topViewHeight: CGFloat {
        get {
            return 80
        }
    }
    
    class var detailsViewHeight: CGFloat {
        get {
            return 300
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
        if !didSetupConstraints {
            topView.autoPinEdgeToSuperviewEdge(.Leading, withInset: 8)
            topView.autoPinEdgeToSuperviewEdge(.Trailing, withInset: 8)
            topView.autoSetDimension(.Height, toSize: FoldingTripEventCell.topViewHeight)
            
            self.topView.autoPinEdgeToSuperviewEdge(.Top, withInset: 8).autoIdentify("ForegroundViewTop")
            attractionName.autoCenterInSuperview()
            

            detailsView.autoPinEdgeToSuperviewEdge(.Leading, withInset: 8)
            detailsView.autoPinEdgeToSuperviewEdge(.Trailing, withInset: 8)
            detailsView.autoSetDimension(.Height, toSize: FoldingTripEventCell.detailsViewHeight)
            self.detailsView.autoPinEdgeToSuperviewEdge(.Top, withInset: 8).autoIdentify("ContainerViewTop")
            
            for i in 0...self.itemCount-1 {
                let view = self.detailSegments[i]
                view.autoPinEdgeToSuperviewEdge(.Leading, withInset: 8)
                view.autoPinEdgeToSuperviewEdge(.Trailing, withInset: 8)
                let segHeight = FoldingTripEventCell.detailsViewHeight/CGFloat(self.detailSegments.count)
                view.autoSetDimension(.Height, toSize: segHeight)
                let topEdge = segHeight * CGFloat(i)
                view.autoPinEdgeToSuperviewEdge(.Top, withInset: topEdge)
            }
            
            didSetupConstraints = true
        }
        super.updateConstraints()
    }
    
    func initViews() {
        self.backgroundColor = UIColor.fomoPeriwinkle()
        self.itemCount = 3
        if attraction != nil {
            attractionName.text = attraction?.name
        } else {
            attractionName.text = "Test"
        }
        topView.backgroundColor = UIColor.fomoWhite()
        topView.layer.cornerRadius = 10
        topView.layer.masksToBounds = true
        
        
        detailsView.backgroundColor = UIColor.fomoTeal()
        detailsView.layer.cornerRadius = 10
        detailsView.layer.masksToBounds = true
        
        topView.addSubview(attractionName)
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
            view.backgroundColor = UIColor.fomoSand()
            detailsView.addSubview(view)
        }
        
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: "didRightSwipe:")
        swipeRightGesture.direction = UISwipeGestureRecognizerDirection.Right
        self.contentView.addGestureRecognizer(swipeRightGesture)
        
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: "didLeftSwipe:")
        swipeLeftGesture.direction = UISwipeGestureRecognizerDirection.Left
        self.contentView.addGestureRecognizer(swipeLeftGesture)
        
    }
    
    func didLeftSwipe(gesture: UISwipeGestureRecognizer) {
        print("Swipe Left")
    }
    
    func didRightSwipe(gesture: UISwipeGestureRecognizer) {
        print("Swipe Right")
    }
    
    override func animationDuration(itemIndex:NSInteger, type:AnimationType)-> NSTimeInterval {
        let durations = [0.4, 0.4, 0.4]
        return durations[itemIndex]
    }

}

class ForegroundView: RotatedView {
    
}
