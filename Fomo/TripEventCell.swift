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
    
    var labelView: UILabel!

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
        labelView.autoCenterInSuperview()
        
        super.updateConstraints()
    }
    
    func initViews() {
        labelView = UILabel()
        labelView.text = "Testing"
        addSubview(labelView)
    }

}
