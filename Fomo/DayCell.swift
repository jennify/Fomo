//
//  DayCell.swift
//  Fomo
//
//  Created by Christian Deonier on 3/5/16.
//  Copyright © 2016 TeamAwesome. All rights reserved.
//

import UIKit

class DayCell: UICollectionViewCell {
    
    var dayName: UILabel = UILabel.newAutoLayoutView()
    
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
            dayName.autoSetDimension(.Height, toSize: 50.0)
            dayName.autoSetDimension(.Width, toSize: 50.0)
            dayName.textAlignment = .Center
            
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
    
    func initViews() {
        dayName = UILabel()
        dayName.text = "Testing"
        dayName.backgroundColor = UIColor.fomoWhite()
        dayName.layer.cornerRadius = 5
        dayName.clipsToBounds = true
        
        addSubview(dayName)
    }
}
