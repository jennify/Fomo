//
// PreferenceCell.swift
// ============================


import UIKit


class PreferenceCell: UICollectionViewCell {
    
    let preferenceName: UILabel = UILabel.newAutoLayoutView()
    
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
    
    override func updateConstraints() {
        if !didSetupConstraints {
            preferenceName.autoCenterInSuperview()
            preferenceName.autoSetDimension(.Height, toSize: 50)
            preferenceName.autoSetDimension(.Width, toSize: 50)
            preferenceName.textAlignment = .Center
            
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
    
    func initViews() {
        preferenceName.backgroundColor = UIColor.whiteColor()
        preferenceName.layer.cornerRadius = 5
        preferenceName.clipsToBounds = true
        
        addSubview(preferenceName)
    }
}
