//
//  FriendsCell.swift
//  Fomo
//
//  Created by Christian Deonier on 3/5/16.
//  Copyright © 2016 TeamAwesome. All rights reserved.
//

import UIKit

class FriendCell: UITableViewCell {

    var profilePhoto: UIImageView = UIImageView.newAutoLayoutView()
    var friendName: UILabel = UILabel.newAutoLayoutView()
    
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
            profilePhoto.autoSetDimension(.Height, toSize: 50)
            profilePhoto.autoSetDimension(.Width, toSize: 50)
            profilePhoto.autoPinEdgeToSuperviewEdge(.Left, withInset: 10)
            profilePhoto.autoAlignAxisToSuperviewAxis(.Horizontal)
            profilePhoto.layer.cornerRadius = 25
            profilePhoto.clipsToBounds = true
            
            friendName.autoPinEdge(.Left, toEdge: .Right, ofView: profilePhoto, withOffset: 10)
            friendName.autoPinEdgeToSuperviewEdge(.Right)
            friendName.autoAlignAxis(.Horizontal, toSameAxisOfView: profilePhoto)
            
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
    
    func initViews() {
        addSubview(profilePhoto)
        addSubview(friendName)
    }
}
