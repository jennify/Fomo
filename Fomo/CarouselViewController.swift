//
//  CarouselViewController.swift
//  Fomo
//
//  Created by Christian Deonier on 3/19/16.
//  Copyright © 2016 TeamAwesome. All rights reserved.
//

import UIKit

class CarouselViewController: UIViewController, CarouselCollectionViewDelegate {
    
    let collectionView: CarouselCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        return CarouselCollectionView(frame: CGRectZero, collectionViewLayout: layout)
    }()
    
    var imagePaths: [String]?
    var didSetupConstraints = false
    
    let imageLoader: ((imageView: UIImageView, imagePath : String, completion: (newImage: Bool) -> ()) -> ()) = {
        (imageView: UIImageView, imagePath : String, completion: (newImage: Bool) -> ()) in
        
        imageView.setImageWithURL(NSURL(string: imagePath)!)
        completion(newImage: imageView.image != nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
    }
    
    func configureCollectionView() {
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.imagePaths = imagePaths!
        collectionView.selectDelegate = self
        collectionView.commonImageLoader = self.imageLoader
        collectionView.maximumZoom = 2.0
        collectionView.reloadData()
    }
    
    override func loadView() {
        view = UIView()
        view.addSubview(collectionView)
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        if (!didSetupConstraints) {
            collectionView.autoPinEdgesToSuperviewEdges()
            
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
    
    func cellClick() {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
