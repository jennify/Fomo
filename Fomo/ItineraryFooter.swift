//
//  ItineraryFooter.swift
// ============================


import UIKit


class ItineraryFooter: UITableViewCell {
    
    var actionLabel: UILabel = UILabel.newAutoLayoutView()
    let continueImageView: UIImageView = UIImageView.newAutoLayoutView()
    let bgButtonView: UIView = UIView.newAutoLayoutView()
    var parentVC: UIViewController?
    var didSetupConstraints = false

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
//            continueImageView.autoSetDimension(.Width, toSize: 40)
//            continueImageView.autoSetDimension(.Height, toSize: 40)
//            continueImageView.autoPinEdgeToSuperviewEdge(.Top, withInset: 15, relation: .Equal)
//            continueImageView.autoAlignAxisToSuperviewAxis(.Vertical)

            actionLabel.autoCenterInSuperview()
//            actionLabel.autoAlignAxisToSuperviewAxis(.Vertical)
//            actionLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: continueImageView, withOffset: 4)
            
            bgButtonView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 32, left: 8, bottom: 32, right: 8))
            
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
    
    func initViews() {
        
        actionLabel.text = "Finished Planning? Finalize Trip."
        actionLabel.font = UIFont.fomoH2()
        actionLabel.textColor = UIColor.darkGrayColor()
        
//        continueImageView.image = UIImage(named: "smiling")
        bgButtonView.backgroundColor = UIColor.fomoHighlight()
        bgButtonView.layer.cornerRadius = 10
        bgButtonView.clipsToBounds = true
        
        addSubview(bgButtonView)
        bgButtonView.addSubview(actionLabel)
//        addSubview(continueImageView)
        
    }
}
