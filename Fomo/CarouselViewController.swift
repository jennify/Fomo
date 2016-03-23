//
//  NewCarouselViewController.swift
//  Fomo
//
//  Created by Christian Deonier on 3/22/16.
//  Copyright © 2016 TeamAwesome. All rights reserved.
//

import UIKit

class CarouselViewController: UIViewController {
    
    var imageUrls: [String] = []
    var imageViews: [UIImageView] = []
    
    var didSetupConstraints = false
    
    let scrollView = UIScrollView.newAutoLayoutView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CarouselViewController.onTap)))
    }
    
    func onTap() {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor.clearColor()
        
        view.addSubview(scrollView)
        
        populateImageViews()
        
        for imageView in imageViews {
            scrollView.addSubview(imageView)
        }
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        if (!didSetupConstraints) {
            scrollView.autoPinEdgesToSuperviewEdges()
            
            let imageViews: NSArray = self.imageViews
            imageViews.autoSetViewsDimension(.Height, toSize: 300)
            imageViews.autoSetViewsDimension(.Width, toSize: 420)
            
            imageViews.autoDistributeViewsAlongAxis(.Horizontal, alignedTo: .Horizontal, withFixedSpacing: 15, insetSpacing: false)
            let firstImageView = imageViews[0] as! UIView
            firstImageView.autoAlignAxisToSuperviewAxis(.Horizontal)
            
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
    
    func populateImageViews() {
        for imageUrl in imageUrls {
            let imageView = UIImageView()
            imageView.setImageWithURL(NSURL(string: imageUrl)!)
            imageView.contentMode = .ScaleAspectFill
            imageView.clipsToBounds = true
            imageViews.append(imageView)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
