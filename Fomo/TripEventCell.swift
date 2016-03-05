//
//  TripEventCell.swift
//  Fomo
//
//  Created by Christian Deonier on 3/4/16.
//  Copyright © 2016 TeamAwesome. All rights reserved.
//

import UIKit
import PureLayout

class TripEventCell: UITableViewCell {
    
    var attractionName: UILabel = UILabel.newAutoLayoutView()
    
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
            attractionName.autoCenterInSuperview()
            
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
    
    func initViews() {
        attractionName = UILabel()
        attractionName.text = "Testing"
        addSubview(attractionName)
    }

}
