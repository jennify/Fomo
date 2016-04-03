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
            actionLabel.autoCenterInSuperview()
            
            bgButtonView.autoCenterInSuperview()
            bgButtonView.autoSetDimension(.Height, toSize: 30)
            bgButtonView.autoPinEdgeToSuperviewEdge(.Right, withInset: 8)
            bgButtonView.autoPinEdgeToSuperviewEdge(.Left, withInset: 8)
            bgButtonView.autoPinEdgeToSuperviewEdge(.Top, withInset: 10)
            bgButtonView.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 10)
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
    
    func initViews() {
        actionLabel.text = "Finished Planning? Finalize Trip."
        actionLabel.font = UIFont.fomoBold(18)
        actionLabel.textColor = UIColor.darkGrayColor()
        actionLabel.sizeToFit()
        
        bgButtonView.backgroundColor = UIColor.fomoHighlight()
        bgButtonView.layer.cornerRadius = 5
        bgButtonView.clipsToBounds = true
        
        addSubview(bgButtonView)
        bgButtonView.addSubview(actionLabel)
        
    }
}
