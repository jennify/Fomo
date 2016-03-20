//
// DecisionViewController.swift
// ============================
// ** DEPRECATED **


import UIKit


class DecisionViewController: UIViewController {
    
    let profileView: DraggableAttractionView = DraggableAttractionView.newAutoLayoutView()
    var nameLabel: UILabel = UILabel.newAutoLayoutView()
    var originalTranform: CGAffineTransform?
    var originalCenter: CGPoint?
    var didSetupConstraints = false

    let tripevent: TripEvent = TripEvent.generateTestInstance(City.generateTestInstance())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAttractionView()
        setUpNavigationBar()
    }
    
    override func loadView() {
        view = UIView()
        
        view.backgroundColor = UIColor.fomoBackground()
        view.addSubview(profileView)
        view.addSubview(nameLabel)

        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        if (!didSetupConstraints) {
            profileView.autoPinToTopLayoutGuideOfViewController(self, withInset: 16)
            profileView.autoAlignAxisToSuperviewAxis(.Vertical)
            profileView.autoSetDimension(.Height, toSize: 312)
            profileView.autoSetDimension(.Width, toSize: 312)
            
            nameLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: profileView, withOffset: 10)
            nameLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: 10)
            
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
    
    func setUpAttractionView() {
        let attraction = tripevent.attraction
        let attractionImageUrl = NSURL(string: attraction!.imageUrls![0])!
        profileView.attractionImageView.setImageWithURL(attractionImageUrl)
        profileView.clipsToBounds = true
        profileView.layer.cornerRadius = 10
        
        nameLabel.text = attraction!.name
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "onTap:")
        profileView.addGestureRecognizer(tapGestureRecognizer)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onPan:")
        profileView.addGestureRecognizer(panGestureRecognizer)
    }

    // Tap to view attraction details
    func onTap(sender: UITapGestureRecognizer) {
        self.performSegueWithIdentifier("attractionSegue", sender: self)
    }

    func onPan(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        let point = sender.locationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            self.originalCenter = self.profileView.center
            self.originalTranform = self.profileView.transform
        } else if sender.state == UIGestureRecognizerState.Changed {
            
            var multiplier = 1.0
            if point.y < profileView.frame.height/2 {
                multiplier = -1.0
            } else {
                multiplier = 1.0
            }
            self.profileView.center = CGPoint(x: self.originalCenter!.x + sender.translationInView(view).x, y: originalCenter!.y)
            let xOffset = translation.x
            let angle = CGFloat(multiplier * 1 * M_PI/180) / 20 * xOffset
            self.profileView.transform = CGAffineTransformRotate(originalTranform!, angle)
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            
            if translation.x > 80 || translation.x < -80 {
                self.profileView.hidden = true
            } else {
                self.profileView.transform = originalTranform!
                self.profileView.center = originalCenter!
            }
        }
        
    }
    
    func setUpNavigationBar() {
        navigationItem.title = tripevent.attraction!.name
    }
}
