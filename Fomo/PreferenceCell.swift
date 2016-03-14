//
// PreferenceCell.swift
// ============================


import UIKit


class PreferenceCell: UICollectionViewCell {
    
    var preferenceName: UILabel = UILabel.newAutoLayoutView()
    
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
            preferenceName.autoSetDimension(.Height, toSize: 50.0)
            preferenceName.autoSetDimension(.Width, toSize: 50.0)
            preferenceName.textAlignment = .Center
            
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
    
    func initViews() {
        preferenceName = UILabel()
        preferenceName.text = "Testing"
        preferenceName.backgroundColor = UIColor.whiteColor()
        preferenceName.layer.cornerRadius = 5
        preferenceName.clipsToBounds = true
        
        addSubview(preferenceName)
    }
}
