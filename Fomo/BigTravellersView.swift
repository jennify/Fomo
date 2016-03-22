//
//  BigTravellersView.swift
//  Fomo
//
//  Created by Christian Deonier on 3/21/16.
//  Copyright © 2016 TeamAwesome. All rights reserved.
//

import UIKit

class BigTravellersView: UIView {
    
    var travellers: [User] = []
    var travellerHalos: [UIView] = []
    var delegate: TravellersViewDelegate?
    
    var didSetupConstraints = false
    
    var faceHeight: CGFloat = 80
    
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
        travellers = [User.generateTestInstance(), User.generateTestInstance(), User.generateTestInstance()]
        
        addHalos()
    }
    
    func clearHalos() {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
    }
    
    func addHalos() {
        for traveller in travellers {
            let profilePhoto = createHalo()
            profilePhoto.setImageWithURL(NSURL(string: traveller.profileImageURL!)!)
            travellerHalos.append(profilePhoto)
        }
        
        for halo in travellerHalos {
            addSubview(halo)
        }
    }
    
    override func updateConstraints() {
        if !didSetupConstraints {
            let views: NSArray = travellerHalos
            views.autoSetViewsDimension(.Height, toSize: faceHeight)
            views.autoSetViewsDimension(.Width, toSize: faceHeight)
            
            views.autoDistributeViewsAlongAxis(.Horizontal, alignedTo: .Horizontal,  withFixedSpacing: 15)
            views[0].autoAlignAxisToSuperviewAxis(.Horizontal)
            
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
    
    func createHalo() -> UIImageView {
        let halo = UIImageView.newAutoLayoutView()
        halo.layer.cornerRadius = faceHeight/2
        halo.clipsToBounds = true
        return halo
    }
}
