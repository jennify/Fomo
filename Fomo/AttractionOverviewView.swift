//
// AttractionOverviewView.swift
// ============================


import UIKit


class AttractionOverviewView: UIView {

    var navigationBar: UINavigationBar = UINavigationBar.newAutoLayoutView()
    var image: UIImageView = UIImageView.newAutoLayoutView()
    var reviewCount: UILabel = UILabel.newAutoLayoutView()
    var attractionName: UILabel = UILabel.newAutoLayoutView()
    var border: UIView = UIView.newAutoLayoutView()
    var downvoteIcon: UIImageView = UIImageView.newAutoLayoutView()
    var neutralIcon: UIImageView = UIImageView.newAutoLayoutView()
    var upvoteIcon: UIImageView = UIImageView.newAutoLayoutView()
    var downvoteCount: UILabel = UILabel.newAutoLayoutView()
    var neutralCount: UILabel = UILabel.newAutoLayoutView()
    var upvoteCount: UILabel = UILabel.newAutoLayoutView()
    var voteNames: UILabel = UILabel.newAutoLayoutView()
    var category: UILabel = UILabel.newAutoLayoutView()
    var attractionDescription: UILabel = UILabel.newAutoLayoutView()

    var didSetupConstraints = false
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initViews()
        updateConstraints()
    }
    
    override func updateConstraints() {
        if !didSetupConstraints {
            navigationBar.autoPinEdgeToSuperviewEdge(.Top)
            navigationBar.autoPinEdgeToSuperviewEdge(.Left)
            navigationBar.autoPinEdgeToSuperviewEdge(.Right)
            navigationBar.autoSetDimension(.Height, toSize: 44)
            
            image.autoPinEdge(.Top, toEdge: .Bottom, ofView: navigationBar)
            image.autoPinEdgeToSuperviewEdge(.Left)
            image.autoPinEdgeToSuperviewEdge(.Right)
            image.autoSetDimension(.Height, toSize: 200)

            reviewCount.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: image, withOffset: -10)
            reviewCount.autoPinEdgeToSuperviewEdge(.Left, withInset: 10)

            attractionName.autoPinEdge(.Top, toEdge: .Bottom, ofView: image, withOffset: 10)
//            attractionName.autoPinEdgeToSuperviewEdge(.Left, withInset: 10)
            attractionName.autoConstrainAttribute(.Left, toAttribute: .Left, ofView: reviewCount)
            
//            border.autoPinEdgeToSuperviewEdge(.Left, withInset: 10)
            border.autoConstrainAttribute(.Left, toAttribute: .Left, ofView: attractionName)

            border.autoPinEdge(.Top, toEdge: .Bottom, ofView: attractionName, withOffset: 5)
            border.autoSetDimension(.Height, toSize: 1)
            border.autoSetDimension(.Width, toSize: 50)
            
            downvoteIcon.autoSetDimension(.Height, toSize: 16)
            downvoteIcon.autoSetDimension(.Width, toSize: 16)
            neutralIcon.autoSetDimension(.Height, toSize: 16)
            neutralIcon.autoSetDimension(.Width, toSize: 16)
            upvoteIcon.autoSetDimension(.Height, toSize: 16)
            upvoteIcon.autoSetDimension(.Width, toSize: 16)
            downvoteIcon.autoAlignAxis(.Horizontal, toSameAxisOfView: neutralIcon)
            downvoteIcon.autoAlignAxis(.Horizontal, toSameAxisOfView: upvoteIcon)
            downvoteIcon.autoConstrainAttribute(.Left, toAttribute: .Left, ofView: border)
//            downvoteIcon.autoPinEdgeToSuperviewEdge(.Left, withInset: 10)
            downvoteIcon.autoPinEdge(.Top, toEdge: .Bottom, ofView: border, withOffset: 5)
            neutralIcon.autoPinEdge(.Left, toEdge: .Right, ofView: downvoteIcon, withOffset: 20)
            upvoteIcon.autoPinEdge(.Left, toEdge: .Right, ofView: neutralIcon, withOffset: 20)

            downvoteIcon.autoAlignAxis(.Vertical, toSameAxisOfView: downvoteCount)
            neutralIcon.autoAlignAxis(.Vertical, toSameAxisOfView: neutralCount)
            upvoteIcon.autoAlignAxis(.Vertical, toSameAxisOfView: upvoteCount)
            downvoteCount.autoAlignAxis(.Horizontal, toSameAxisOfView: neutralCount)
            downvoteCount.autoAlignAxis(.Horizontal, toSameAxisOfView: upvoteCount)
            downvoteCount.autoPinEdge(.Top, toEdge: .Bottom, ofView: downvoteIcon, withOffset: 5)
            
            voteNames.autoPinEdge(.Left, toEdge: .Right, ofView: upvoteIcon, withOffset: 10)
            voteNames.autoConstrainAttribute(.Top, toAttribute: .Top, ofView: upvoteIcon)
            voteNames.numberOfLines = 0
            voteNames.textAlignment = .Left
            
            category.autoConstrainAttribute(.Left, toAttribute: .Left, ofView: border)
            category.autoPinEdge(.Top, toEdge: .Bottom, ofView: voteNames, withOffset: 10)

            attractionDescription.autoConstrainAttribute(.Left, toAttribute: .Left, ofView: category)
            attractionDescription.autoPinEdge(.Top, toEdge: .Bottom, ofView: voteNames, withOffset: 10)
            attractionDescription.numberOfLines = 0
            attractionDescription.textAlignment = .Left

            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
    
    func initViews() {
        addSubview(navigationBar)
        addSubview(image)
        addSubview(reviewCount)
        addSubview(attractionName)
        addSubview(downvoteCount)
        addSubview(neutralCount)
        addSubview(upvoteCount)
        addSubview(downvoteIcon)
        addSubview(neutralIcon)
        addSubview(upvoteIcon)
        addSubview(voteNames)
        addSubview(border)
        addSubview(category)
        addSubview(attractionDescription)
    }
}
