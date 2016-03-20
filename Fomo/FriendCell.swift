//
// FriendCell.swift
// ============================


import UIKit


protocol FriendCellDelegate {
    func inviteFriendToApp(cell: FriendCell)
    func inviteFriendToTrip(cell: FriendCell)
}

class FriendCell: UITableViewCell {

    let profilePhoto: UIImageView = UIImageView.newAutoLayoutView()
    let friendName: UILabel = UILabel.newAutoLayoutView()
    
    var delegate: FriendCellDelegate?

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
            profilePhoto.autoPinEdgeToSuperviewEdge(.Top, withInset: 10)
            profilePhoto.autoPinEdgeToSuperviewEdge(.Left, withInset: 10)
            profilePhoto.layer.cornerRadius = 25
            profilePhoto.clipsToBounds = true
            
            friendName.autoPinEdge(.Left, toEdge: .Right, ofView: profilePhoto, withOffset: 10)
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
