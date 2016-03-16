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
            views.autoSetViewsDimension(.Height, toSize: faceHeight)
            views.autoSetViewsDimension(.Width, toSize: faceHeight)

            views.autoDistributeViewsAlongAxis(.Horizontal, alignedTo: .Horizontal, withFixedSize: faceHeight)
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
    
    func createAddTravellerButton() -> UIImageView {
        let button = createHalo()
        button.image = UIImage(named: "plus")
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
