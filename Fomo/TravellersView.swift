//
//  TravellersView.swift
// ============================


import UIKit


protocol TravellersViewDelegate {
    func addNewTraveller()
}

class TravellersView: UIView {
    
    var travellers: [User] = []
    var travellerHalos: [UIView] = []
    var delegate: TravellersViewDelegate?
    
    var didSetupConstraints = false
    
    var faceHeight: CGFloat = 30
    
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
        self.backgroundColor = UIColor.fomoSand()
        
        if Cache.itinerary != nil {
            travellers = Cache.itinerary!.travellers!
        } else {
            travellers = [User.generateTestInstance(), User.generateTestInstance(), User.generateTestInstance()]
        }
        
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
