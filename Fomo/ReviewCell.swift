//
// ReviewCell.swift
// ============================


import UIKit


class ReviewCell: UITableViewCell {

    let rating: UILabel = UILabel.newAutoLayoutView()
    let date: UILabel = UILabel.newAutoLayoutView()
    var message: UILabel = UILabel.newAutoLayoutView()
    
    var didSetupConstraints = false
    
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
    
    override func updateConstraints() {
        if !didSetupConstraints {
            rating.autoPinEdgeToSuperviewEdge(.Left, withInset: 10)
            rating.autoPinEdgeToSuperviewEdge(.Top, withInset: 10)            
            
            date.autoConstrainAttribute(.Left, toAttribute: .Left, ofView: rating)
            date.autoPinEdge(.Top, toEdge: .Bottom, ofView: rating, withOffset: 5)

            message.autoConstrainAttribute(.Left, toAttribute: .Left, ofView: date)
            message.autoPinEdge(.Top, toEdge: .Bottom, ofView: date, withOffset: 5)
            message.lineBreakMode = NSLineBreakMode.ByWordWrapping
            message.numberOfLines = 0
            
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
    
    func initViews() {
        addSubview(rating)
        addSubview(date)
        addSubview(message)
    }
}
