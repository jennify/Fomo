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
    var loadCache = true
    
    init(travellers: [User]) {
        self.travellers = travellers
        super.init(frame: .zero)
        initViews()
        updateConstraints()
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
    
    class func createTravellersViewWithUsers(users: [User]?) -> TravellersView {
        let t = TravellersView()
        t.setTravellerFaces(users)
        return t
    }
    
    func setTravellerFaces(users: [User]?) {
        if users != nil {
            travellers = users!
            loadCache = false
            initViews()
            updateConstraints()
            self.setNeedsDisplay()
        }
    }

    func initViews() {
        travellerHalos = []
        if loadCache {
            if Cache.itinerary != nil {
                travellers = Cache.itinerary!.travellers!
                
            } else {
                print("Itinerary in cache does not exist! Oh noes.")
                travellers = [User.generateTestInstance()]
                
            }
        } else {
            // Not loading from cache
            
        }
        
        
        
        self.backgroundColor = UIColor.clearColor()
        
        for traveller in travellers {
            let profilePhoto = createHalo()
            if traveller.profileImageURL == nil || traveller.profileImageURL?.characters.count == 0 {
                profilePhoto.image = UIImage(named: "noPerson")
            } else {
                travellerHalos.append(profilePhoto)
                profilePhoto.setImageWithURL(NSURL(string: traveller.profileImageURL!)!)
            }
            
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
            let view = views[0] as! UIView
            view.autoAlignAxisToSuperviewAxis(.Horizontal)
            
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
