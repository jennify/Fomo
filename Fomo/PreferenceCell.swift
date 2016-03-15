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
            preferenceIcon.autoCenterInSuperview()
            preferenceIcon.autoSetDimension(.Height, toSize: 35)
            preferenceIcon.autoSetDimension(.Width, toSize: 35)
            
            preferenceName.autoPinEdge(.Top, toEdge: .Bottom, ofView: preferenceIcon, withOffset: 10)
            preferenceName.autoAlignAxis(.Vertical, toSameAxisOfView: preferenceIcon)

            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
    
    func initViews() {
        preferenceIcon.userInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "togglePreference:")
        preferenceIcon.addGestureRecognizer(tapGestureRecognizer)
        preferenceName.font = UIFont.systemFontOfSize(14)

        addSubview(preferenceIcon)
        addSubview(preferenceName)
    }
    
    // Tap icon to toggle preference
    func togglePreference(sender: UITapGestureRecognizer) {
        if self.preferenceSelected {
            self.layer.borderWidth = 0
            preferenceName.font = UIFont.systemFontOfSize(14, weight: UIFontWeightRegular)
            preferenceSelected = false
            self.delegate?.updateUserPreference(self.attractionType, cell: self)
            // TODO: update user preferences array
        } else {
            self.layer.borderWidth = 1
            self.layer.cornerRadius = 10
            preferenceName.font = UIFont.systemFontOfSize(14, weight: UIFontWeightBold)
            preferenceSelected = true
            self.delegate?.updateUserPreference(self.attractionType, cell: self)
            // TODO: update user preferences array
        }
    }
}