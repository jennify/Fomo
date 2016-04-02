//
//  MapInfoView.swift
//  Fomo
//
//  Created by Christian Deonier on 3/30/16.
//  Copyright © 2016 TeamAwesome. All rights reserved.
//

import UIKit

protocol MapInfoViewDelegate {
    func enhance()
}

class MapInfoView: UIView {
    
    var attraction: Attraction!
    
    var backgroundOverlay: UIView!
    var image: UIImageView!
    var name: UILabel!
    var enhanceButton: UIButton!
    var ratingView: UIView!
    var ratingLabel: UILabel!
    var delegate: MapInfoViewDelegate?
    var enhanced: Bool = false
    
    var didSetupConstraints = false
    
    init(attraction: Attraction) {
        self.attraction = attraction
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
    
    func initViews() {
        setUpBackgroundOverlay()
        setUpImage()
        setUpName()
        setUpEnhanceButton()
        setUpRatingView()
    }
    
    func setUpBackgroundOverlay() {
        backgroundOverlay = UIView()
        backgroundOverlay.backgroundColor = UIColor.blackColor()
        backgroundOverlay.alpha = 0.7
        addSubview(backgroundOverlay)
    }
    
    func setUpImage() {
        image = UIImageView()
        image.setImageWithURL(NSURL(string: attraction.imageUrls.first!)!)
        addSubview(image)
    }
    
    func setUpName() {
        name = UILabel()
        name.textColor = UIColor.whiteColor()
        name.text = attraction.name!
        addSubview(name)
    }
    
    func setUpEnhanceButton() {
        let binocularsImage = UIImage(named: "binoculars")
        enhanceButton = UIButton(type: .Custom)
        enhanceButton.setImage(binocularsImage, forState: .Normal)
        enhanceButton.addTarget(self, action: #selector(MapInfoView.enhance), forControlEvents: .TouchUpInside)
        addSubview(enhanceButton)
    }
    
    func setUpRatingView() {
        ratingView = UIView()
        ratingLabel = UILabel()
        
        var ratingText = ""
        if attraction!.rating == nil {
            ratingText = "?"
        } else {
            ratingText = "\(attraction!.rating!)"
        }
        
        ratingLabel.text = ratingText
        ratingLabel.font = UIFont.fomoH1()
        ratingLabel.textColor = UIColor.whiteColor()
        
        ratingView.backgroundColor = UIColor.fomoHighlight()
        ratingView.layer.cornerRadius = 5
        ratingView.clipsToBounds = true
        
        ratingView.addSubview(ratingLabel)
        addSubview(ratingView)
    }
    
    override func updateConstraints() {
        if !didSetupConstraints {
            updateConstraintsBackgroundOverlay()
            updateConstraintsImage()
            updateConstraintsName()
            updateConstraintsEnhanceButton()
            updateConstraintsRatingView()
            
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
    
    func updateConstraintsBackgroundOverlay() {
        backgroundOverlay.configureForAutoLayout()
        backgroundOverlay.autoPinEdgeToSuperviewEdge(.Left)
        backgroundOverlay.autoPinEdgeToSuperviewEdge(.Right)
        backgroundOverlay.autoPinEdgeToSuperviewEdge(.Bottom)
        backgroundOverlay.autoSetDimension(.Height, toSize: 100)
    }
    
    func updateConstraintsImage() {
        image.configureForAutoLayout()
        image.autoPinEdgeToSuperviewEdge(.Left, withInset: 10)
        image.autoPinEdgeToSuperviewEdge(.Top, withInset: 10)
        image.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 10)
        image.autoSetDimension(.Width, toSize: 120)
    }
    
    func updateConstraintsName() {
        name.configureForAutoLayout()
        name.autoPinEdgeToSuperviewEdge(.Top, withInset: 10)
        name.autoPinEdge(.Left, toEdge: .Right, ofView: image, withOffset: 10)
    }
    
    func updateConstraintsEnhanceButton() {
        enhanceButton.configureForAutoLayout()
        enhanceButton.autoSetDimension(.Height, toSize: 20)
        enhanceButton.autoSetDimension(.Width, toSize: 20)
        enhanceButton.autoPinEdgeToSuperviewEdge(.Right, withInset: 10)
        enhanceButton.autoPinEdgeToSuperviewEdge(.Top, withInset: 10)
    }
    
    func updateConstraintsRatingView() {
        ratingView.configureForAutoLayout()
        ratingLabel.configureForAutoLayout()
        
        ratingView.autoPinEdge(.Left, toEdge: .Right, ofView: image, withOffset: 10)
        ratingView.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 10)
        ratingView.autoSetDimension(.Width, toSize: 40)
        ratingView.autoSetDimension(.Height, toSize: 40)
        
        ratingLabel.autoCenterInSuperview()
    }
    
    func enhance() {
        delegate?.enhance()
    
        enhanced = !enhanced
        if (enhanced) {
            let buttonIcon = UIImage(named: "map")
            enhanceButton.setImage(buttonIcon, forState: .Normal)
        } else {
            let buttonIcon = UIImage(named: "binoculars")
            enhanceButton.setImage(buttonIcon, forState: .Normal)

        }
    }
    
    func refreshView(attraction: Attraction) {
        self.attraction = attraction
        image.setImageWithURL(NSURL(string: attraction.imageUrls.first!)!)
        name.text = attraction.name
        ratingLabel.text = "\(attraction.rating!)"
    }

}
