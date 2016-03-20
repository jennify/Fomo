//
// DayCell.swift
// ============================


import UIKit


class DayCell: UICollectionViewCell {
    var dayNum: Int?
    var dayLabel: UILabel = UILabel.newAutoLayoutView()
    var dayName: UILabel = UILabel.newAutoLayoutView()
    var additionLabel: UILabel = UILabel.newAutoLayoutView()
    var didSetupConstraints = false

    override init(frame: CGRect) {
        super.init(frame: frame)
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
            dayLabel.autoPinEdgeToSuperviewEdge(.Top, withInset: 8)
            dayLabel.autoAlignAxisToSuperviewAxis(.Vertical)
            
            dayName.autoPinEdgeToSuperviewEdge(.Top, withInset: 10)
            dayName.autoSetDimension(.Height, toSize: 50)
            dayName.autoSetDimension(.Width, toSize: 50)
            dayName.textAlignment = .Center
            
            additionLabel.autoCenterInSuperview()
            
            
            didSetupConstraints = true
        }

        super.updateConstraints()
    }

    func initViews() {
        dayLabel.font = UIFont(name: "AppleSDGothicNeo-Light", size: 12)
        
        additionLabel.font = UIFont(name: "AppleSDGothicNeo-Light", size: 20)
        additionLabel.sizeToFit()
        
        dayName.backgroundColor = UIColor.clearColor()
        dayName.font = UIFont(name: "AppleSDGothicNeo-Light", size: 20)
        dayName.sizeToFit()
        
        self.backgroundColor = UIColor.fomoCardBG()
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
        
        addSubview(dayName)
        addSubview(dayLabel)
        addSubview(additionLabel)
    }
}
