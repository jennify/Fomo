//
//  ItineraryFooter.swift
//  Fomo
//
//  Created by Jennifer Lee on 3/15/16.
//  Copyright © 2016 TeamAwesome. All rights reserved.
//

//
// DayHeaderCell.swift
// ============================


import UIKit


class ItineraryFooter: UITableViewCell {
    
    var actionLabel: UILabel = UILabel.newAutoLayoutView()
    let continueImageView: UIImageView = UIImageView.newAutoLayoutView()
    var parentVC: UIViewController?
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
            continueImageView.autoSetDimension(.Width, toSize: 80)
            continueImageView.autoSetDimension(.Height, toSize: 80)
            continueImageView.autoPinEdgeToSuperviewEdge(.Top, withInset: 15, relation: .Equal)
            continueImageView.autoAlignAxisToSuperviewAxis(.Vertical)
            
            actionLabel.autoAlignAxisToSuperviewAxis(.Vertical)
            actionLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: continueImageView, withOffset: 8)
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
    
    func initViews() {
        actionLabel = UILabel()
        actionLabel.text = "Keep Exploring!"
        actionLabel.font = UIFont.fomoParagraph()
        actionLabel.textColor = UIColor.darkGrayColor()
        
        continueImageView.image = UIImage(named: "car")
        
        addSubview(actionLabel)
        addSubview(continueImageView)
    }
}
