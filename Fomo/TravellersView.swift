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
        self.backgroundColor = UIColor.fomoPeriwinkle()
        
        travellers = [User.generateTestInstance(), User.generateTestInstance(), User.generateTestInstance()]
        
        for traveller in travellers {
            let profilePhoto = createHalo()
            profilePhoto.setImageWithURL(NSURL(string: traveller.profileImageURL!)!)
            travellerHalos.append(profilePhoto)
        }

        travellerHalos.append(createAddTravellerButton())
        
        for halo in travellerHalos {
            addSubview(halo)
        }
    }
    
    override func updateConstraints() {
        if !didSetupConstraints {
            let views: NSArray = travellerHalos
            views.autoSetViewsDimension(.Height, toSize: 50)
            views.autoSetViewsDimension(.Width, toSize: 50)

            views.autoDistributeViewsAlongAxis(.Horizontal, alignedTo: .Horizontal, withFixedSize: 50)
            views[0].autoAlignAxisToSuperviewAxis(.Horizontal)
            
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
    
    func createHalo() -> UIImageView {
        let halo = UIImageView.newAutoLayoutView()
        halo.layer.cornerRadius = 25
        halo.clipsToBounds = true
        return halo
    }
    
    func createAddTravellerButton() -> UIImageView {
        let button = createHalo()
        button.image = UIImage(named: "Add Item")
        button.image = button.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        button.tintColor = UIColor.fomoWhite()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "onTapAddTraveller")
        button.addGestureRecognizer(tapGesture)
        button.userInteractionEnabled = true
        
        return button
    }
    
    func onTapAddTraveller() {
        delegate?.addNewTraveller()
    }
}
