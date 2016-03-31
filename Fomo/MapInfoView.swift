//
//  MapInfoView.swift
//  Fomo
//
//  Created by Christian Deonier on 3/30/16.
//  Copyright © 2016 TeamAwesome. All rights reserved.
//

import UIKit

class MapInfoView: UIView {
    
    let attractionName = UILabel.newAutoLayoutView()
    
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
    
    func initViews() {
        attractionName.text = "Hello"
        
        addSubview(attractionName)
    }
    
    override func updateConstraints() {
        if !didSetupConstraints {
            attractionName.autoSetDimension(.Height, toSize: 30)
            attractionName.autoSetDimension(.Width, toSize: 50)
            attractionName.autoCenterInSuperview()
            
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }

}
