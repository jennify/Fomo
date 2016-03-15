//
// DayCell.swift
// ============================


import UIKit


class DayCell: UICollectionViewCell {
    
    let dayName: UILabel = UILabel.newAutoLayoutView()
    
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
            dayName.autoCenterInSuperview()
            dayName.autoSetDimension(.Height, toSize: 50)
            dayName.autoSetDimension(.Width, toSize: 50)
            dayName.textAlignment = .Center
            
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
    
    func initViews() {
        dayName.backgroundColor = UIColor.whiteColor()
        dayName.layer.cornerRadius = 5
        dayName.clipsToBounds = true
        
        addSubview(dayName)
    }
}
