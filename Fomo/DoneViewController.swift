//
//  DoneViewController.swift
// ============================


import UIKit
import SAConfettiView


class DoneViewController: UIViewController {
    
    let coverPhoto: UIImageView = UIImageView.newAutoLayoutView()
    let blurEffectView: UIVisualEffectView = UIVisualEffectView.newAutoLayoutView()
    let doneTitle: UILabel = UILabel.newAutoLayoutView()
    let doneSubtitle: UILabel = UILabel.newAutoLayoutView()
    let travellersView: BigTravellersView = BigTravellersView.newAutoLayoutView()
    let confettiView: SAConfettiView = SAConfettiView.newAutoLayoutView()
    
    var itinerary: Itinerary?
    
    var didSetupConstraints = false

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavigationBar()
        
        travellersView.hidden = true
    }
    
    override func viewDidAppear(animated: Bool) {
        coverPhoto.image = City.getCoverPhoto(itinerary!.tripName!)
        coverPhoto.contentMode = .ScaleAspectFill
        blurEffectView.alpha = 0.75
        
        travellersView.hidden = false
        
        confettiView.startConfetti()
        NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "stopConfetti", userInfo: nil, repeats: true)
    }
    
    func stopConfetti() {
        confettiView.stopConfetti()
    }
    
    func setUpNavigationBar() {
        self.title = "Your Trip"
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        
        blurEffectView.effect = UIBlurEffect(style: .Dark)
        blurEffectView.alpha = 0
        
        doneTitle.font = UIFont(name: "ClickerScript-Regular", size: 60)
        doneTitle.text = "Pack your bags!"
        doneTitle.textColor = UIColor.whiteColor()
        
        doneSubtitle.font = UIFont(name: "ClickerScript-Regular", size: 35)
        doneSubtitle.text = "You're going to \((itinerary!.tripName)!)!"
        doneSubtitle.textColor = UIColor.whiteColor()
        
        confettiView.intensity = 0.75

        view.addSubview(coverPhoto)
        view.addSubview(blurEffectView)
        view.addSubview(doneTitle)
        view.addSubview(travellersView)
        view.addSubview(doneSubtitle)
        view.addSubview(confettiView)

        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        if (!didSetupConstraints) {
            coverPhoto.autoPinEdgesToSuperviewEdges()
            blurEffectView.autoPinEdgesToSuperviewEdges()
            
            doneTitle.autoPinEdgeToSuperviewEdge(.Top, withInset: 200)
            doneTitle.autoAlignAxisToSuperviewAxis(.Vertical)

            travellersView.autoSetDimension(.Height, toSize: travellersView.faceHeight)
            travellersView.autoAlignAxisToSuperviewAxis(.Vertical)
            travellersView.autoPinEdge(.Top, toEdge: .Bottom, ofView: doneTitle, withOffset: 50)
            
            doneSubtitle.autoAlignAxisToSuperviewAxis(.Vertical)
            doneSubtitle.autoPinEdge(.Top, toEdge: .Bottom, ofView: travellersView, withOffset: 50)
            
            confettiView.autoPinEdgesToSuperviewEdges()
            
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
}
