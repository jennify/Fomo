//
//  ReviewCell.swift
//  Fomo
//
//  Created by Connie Yu on 3/13/16.
//  Copyright © 2016 TeamAwesome. All rights reserved.
//

import UIKit
import PureLayout

class ReviewCell: UITableViewCell {

    let message: UILabel = UILabel.newAutoLayoutView()
    let rating: UILabel = UILabel.newAutoLayoutView()
    let date: UILabel = UILabel.newAutoLayoutView()
    
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
            message.autoCenterInSuperview()
            rating.autoCenterInSuperview()
            date.autoCenterInSuperview()
            
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
    
    func initViews() {
        addSubview(message)
        addSubview(rating)
        addSubview(date)
    }
}
