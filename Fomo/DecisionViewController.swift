//
//  DecisionViewController.swift
//  Fomo
//
//  Created by Jennifer Lee on 2/28/16.
//  Copyright © 2016 TeamAwesome. All rights reserved.
//

import UIKit

// TODO: delegate protocol
class DecisionViewController: UIViewController {

    
    @IBOutlet weak var imageView: DraggableAttractionView!
    @IBOutlet weak var nameLabel: UILabel!
    
    let tripevent: TripEvent = TripEvent.generateTestInstance(City.generateTestInstance())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAttractionView()
        setUpNavigationBar()
    }
    
    func setUpAttractionView() {
        let attraction = tripevent.attraction
        let attractionImageUrl = NSURL(string: attraction!.imageUrls![0])!
        imageView.attractionImageView.setImageWithURL(attractionImageUrl)
        
        nameLabel.text = attraction!.name
    }

    func setUpNavigationBar() {
        navigationItem.title = tripevent.attraction!.name
    }
    
    // Swipe to vote
    @IBAction func onAttractionPanGesture(sender: UIPanGestureRecognizer) {
        imageView.translate(view, sender: sender)
    }
    
    // Tap to view attraction details
    @IBAction func onAttractionTapGesture(sender: UITapGestureRecognizer) {
        self.performSegueWithIdentifier("attractionSegue", sender: self)
    }
    
    
    func displayTodo(todo: String) {
        let alertController = UIAlertController(title: "Fomo", message:"TODO: \(todo)", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        presentViewController(alertController, animated: true, completion: nil)
    }
}
