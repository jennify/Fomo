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
            preferenceIcon.autoPinEdgeToSuperviewEdge(.Top, withInset: self.layer.frame.height/4)
            preferenceIcon.autoSetDimension(.Height, toSize: 35)
            preferenceIcon.autoSetDimension(.Width, toSize: 35)
            
            preferenceName.autoPinEdge(.Top, toEdge: .Bottom, ofView: preferenceIcon, withOffset: 6)
            preferenceName.autoAlignAxis(.Vertical, toSameAxisOfView: preferenceIcon)

            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
    
    func initViews() {
        self.userInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "togglePreference:")
        self.addGestureRecognizer(tapGestureRecognizer)
        preferenceName.font = UIFont.fomoBold(17)

        addSubview(preferenceIcon)
        addSubview(preferenceName)
    }
    
    // Tap icon to toggle preference
    func togglePreference(sender: UITapGestureRecognizer) {

        if self.preferenceSelected {
            self.contentView.layer.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1).CGColor
            self.layer.borderWidth = 0
            preferenceSelected = false
            self.delegate?.updateUserPreference(self.attractionType, cell: self)
            // TODO: update user preferences array
        } else {
            self.contentView.layer.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1).CGColor
            preferenceSelected = true
            self.delegate?.updateUserPreference(self.attractionType, cell: self)
            // TODO: update user preferences array
        }
    }
}