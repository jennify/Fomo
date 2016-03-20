//
// PreferenceCell.swift
// ============================


import UIKit


protocol PreferenceCellDelegate {
    func updateUserPreference(preference: AttractionType, cell: PreferenceCell)
}

class PreferenceCell: UICollectionViewCell {
    
    var preferenceIcon: UIImageView = UIImageView.newAutoLayoutView()
    var preferenceName: UILabel = UILabel.newAutoLayoutView()
    var preferenceSelected: Bool = false
    
    var delegate: PreferenceCellDelegate?
    
    var didSetupConstraints = false
    
    var attractionType: AttractionType! {
        didSet {
            preferenceName.text = attractionType.name
            preferenceIcon.image = attractionType.icon
            preferenceIcon.image = preferenceIcon.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        }
    }
    
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
            preferenceIcon.autoAlignAxisToSuperviewAxis(.Vertical)
            preferenceIcon.autoPinEdgeToSuperviewEdge(.Top, withInset: 17)
            preferenceIcon.autoSetDimension(.Height, toSize: 35)
            preferenceIcon.autoSetDimension(.Width, toSize: 35)
            
            preferenceName.autoPinEdge(.Top, toEdge: .Bottom, ofView: preferenceIcon, withOffset: 4)
            preferenceName.autoAlignAxis(.Vertical, toSameAxisOfView: preferenceIcon)

            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
    
    func initViews() {
        self.userInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "togglePreference:")
        self.addGestureRecognizer(tapGestureRecognizer)
        preferenceName.font = UIFont.systemFontOfSize(14)

        addSubview(preferenceIcon)
        addSubview(preferenceName)
    }
    
    // Tap icon to toggle preference
    func togglePreference(sender: UITapGestureRecognizer) {
//        self.contentView.layer.borderWidth = 1
//        self.contentView.layer.borderColor = UIColor.clearColor().CGColor
//        self.contentView.layer.masksToBounds = true
//        self.contentView.layer.cornerRadius = 20 //self.contentView.frame.height/2
//        self.contentView.backgroundColor = UIColor.whiteColor()
        
//        self.layer.shadowColor = UIColor.lightGrayColor().CGColor
//        self.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
//        self.layer.shadowRadius = 1.5
//        self.layer.shadowOpacity = 1.0
//        self.layer.masksToBounds = false

        if self.preferenceSelected {
            self.contentView.layer.borderColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.4).CGColor
            
            self.layer.borderWidth = 0
            preferenceName.font = UIFont.systemFontOfSize(14, weight: UIFontWeightRegular)
            preferenceSelected = false
            self.delegate?.updateUserPreference(self.attractionType, cell: self)
            // TODO: update user preferences array
        } else {
            self.contentView.layer.borderColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.0).CGColor
            
            preferenceSelected = true
            self.delegate?.updateUserPreference(self.attractionType, cell: self)
            // TODO: update user preferences array
        }
    }
}