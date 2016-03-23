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
    
    func setTravellerFaces(users: [User]?) {
        if users != nil {
            travellers = users!
            loadCache = false
            initViews()
            updateConstraints()
        }
    }

    func initViews() {
        if travellers.count == 0 && loadCache {
            if Cache.itinerary != nil {
                travellers = Cache.itinerary!.travellers!
            } else {
                print("Itinerary in cache does not exist! Oh the horror.")
            }
        }
        self.backgroundColor = UIColor.fomoSand()
        
        for traveller in travellers {
            let profilePhoto = createHalo()
            if traveller.profileImageURL == nil || traveller.profileImageURL?.characters.count == 0 {
                profilePhoto.image = UIImage(named: "noPerson")
            } else {
                profilePhoto.setImageWithURL(NSURL(string: traveller.profileImageURL!)!)
            }
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
