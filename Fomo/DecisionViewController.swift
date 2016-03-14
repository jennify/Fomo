//
//  DecisionViewController.swift
//  Fomo
//
//  Created by Jennifer Lee on 2/28/16.
//  Copyright © 2016 TeamAwesome. All rights reserved.
//

import UIKit

class DecisionViewController: UIViewController {
    
    let imageView: DraggableAttractionView = DraggableAttractionView.newAutoLayoutView()
    var nameLabel: UILabel = UILabel.newAutoLayoutView()

    var didSetupConstraints = false

    let tripevent: TripEvent = TripEvent.generateTestInstance(City.generateTestInstance())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAttractionView()
        setUpNavigationBar()
    }
    
    override func loadView() {
        view = UIView()
        view.addSubview(imageView)
        view.addSubview(nameLabel)

        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        if (!didSetupConstraints) {
            imageView.autoPinEdgeToSuperviewEdge(.Top)
            imageView.autoPinEdgeToSuperviewEdge(.Left)
            imageView.autoPinEdgeToSuperviewEdge(.Right)
            imageView.autoSetDimension(.Height, toSize: 240)
            
            nameLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: imageView, withOffset: 10)
            nameLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: 10)
            
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
    
    func setUpAttractionView() {
        let attraction = tripevent.attraction
        let attractionImageUrl = NSURL(string: attraction!.imageUrls![0])!
        imageView.attractionImageView.setImageWithURL(attractionImageUrl)
        
        nameLabel.text = attraction!.name
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "onTap:")
        imageView.addGestureRecognizer(tapGestureRecognizer)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onPan:")
        imageView.addGestureRecognizer(panGestureRecognizer)
    }

    // Tap to view attraction details
    func onTap(sender: UITapGestureRecognizer) {
        self.performSegueWithIdentifier("attractionSegue", sender: self)
    }

    func onPan(sender: UIPanGestureRecognizer) {
        imageView.translate(view, sender: sender)
    }
    
    func setUpNavigationBar() {
        navigationItem.title = tripevent.attraction!.name
    }
}
