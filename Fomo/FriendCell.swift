//
// FriendCell.swift
// ============================


import UIKit


protocol FriendCellDelegate {
    func inviteFriend(cell: FriendCell)
}

class FriendCell: UITableViewCell {

    let profilePhoto: UIImageView = UIImageView.newAutoLayoutView()
    let friendName: UILabel = UILabel.newAutoLayoutView()
    let checkIcon: UIImageView = UIImageView.newAutoLayoutView()
    var friendSelected: Bool = false
    
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
            profilePhoto.autoSetDimension(.Height, toSize: 40)
            profilePhoto.autoSetDimension(.Width, toSize: 40)
            profilePhoto.autoPinEdgeToSuperviewEdge(.Top, withInset: 10)
            profilePhoto.autoPinEdgeToSuperviewEdge(.Left, withInset: 10)
            profilePhoto.layer.cornerRadius = 20
            profilePhoto.clipsToBounds = true
            
            friendName.autoPinEdge(.Left, toEdge: .Right, ofView: profilePhoto, withOffset: 10)
            friendName.autoAlignAxis(.Horizontal, toSameAxisOfView: profilePhoto)

            checkIcon.autoSetDimension(.Height, toSize: 20)
            checkIcon.autoSetDimension(.Width, toSize: 20)
            checkIcon.autoAlignAxis(.Horizontal, toSameAxisOfView: profilePhoto)
            checkIcon.autoPinEdgeToSuperviewEdge(.Right, withInset: 20)

            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
    
    func initViews() {
        checkIcon.image = UIImage(named: "checkempty")
        checkIcon.image = checkIcon.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        checkIcon.tintColor = UIColor.fomoHamburgerBGColor()

        checkIcon.userInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "toggleInvite:")
        self.addGestureRecognizer(tapGestureRecognizer)
        
        addSubview(profilePhoto)
        addSubview(friendName)
        addSubview(checkIcon)
    }
    
    func toggleInvite(sender: UITapGestureRecognizer) {
        if self.friendSelected {
            friendSelected = false
            checkIcon.image = UIImage(named: "checkempty")
            checkIcon.image = checkIcon.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            checkIcon.tintColor = UIColor.fomoHamburgerBGColor()
        } else {
            friendSelected = true
            delegate?.inviteFriend(self)
            checkIcon.image = UIImage(named: "checkfilled")
            checkIcon.image = checkIcon.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            checkIcon.tintColor = UIColor.fomoHighlight()
        }
    }
}
