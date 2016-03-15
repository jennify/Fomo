//
// AttractionOverviewView.swift
// ============================


import UIKit


class AttractionOverviewView: UIView {

    let contentView: UIView = UIView.newAutoLayoutView()
    let image: UIImageView = UIImageView.newAutoLayoutView()
    let reviewCount: UILabel = UILabel.newAutoLayoutView()
    let attractionName: UILabel = UILabel.newAutoLayoutView()
    let border: UIView = UIView.newAutoLayoutView()
    let downvoteIcon: UIImageView = UIImageView.newAutoLayoutView()
    let neutralIcon: UIImageView = UIImageView.newAutoLayoutView()
    let upvoteIcon: UIImageView = UIImageView.newAutoLayoutView()
    let downvoteCount: UILabel = UILabel.newAutoLayoutView()
    let neutralCount: UILabel = UILabel.newAutoLayoutView()
    let upvoteCount: UILabel = UILabel.newAutoLayoutView()
    let voteNames: UILabel = UILabel.newAutoLayoutView()
    let category: UILabel = UILabel.newAutoLayoutView()
    let attractionDescription: UILabel = UILabel.newAutoLayoutView()

    var didSetupConstraints = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
        updateConstraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }

    override func updateConstraints() {
        if !didSetupConstraints {
            image.autoPinEdgeToSuperviewEdge(.Top)
            image.autoPinEdgeToSuperviewEdge(.Left)
            image.autoPinEdgeToSuperviewEdge(.Right)
            image.autoSetDimension(.Height, toSize: 200)

            reviewCount.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: image, withOffset: -10)
            reviewCount.autoPinEdgeToSuperviewEdge(.Left, withInset: 10)

            attractionName.autoPinEdge(.Top, toEdge: .Bottom, ofView: image, withOffset: 10)
            attractionName.autoConstrainAttribute(.Left, toAttribute: .Left, ofView: reviewCount)
            
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

    
    func initSubviews() {
        contentView.frame = bounds
        addSubview(contentView)
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
