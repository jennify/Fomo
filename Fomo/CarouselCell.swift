//
//  CarouselCell.swift
//  Fomo
//
//  Created by Christian Deonier on 3/19/16.
//  Copyright © 2016 TeamAwesome. All rights reserved.
//

import UIKit

class CarouselCell: UICollectionViewCell {
    
    var scrollView : CarouselCellScrollView = CarouselCellScrollView.newAutoLayoutView()
    
    var didSetupConstraints = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
        updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViews()
        updateConstraints()
    }
    
    func initViews() {       
        addSubview(scrollView)
    }
    
    override func updateConstraints() {
        if !didSetupConstraints {
            scrollView.autoPinEdgesToSuperviewEdges()
            
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
    
    var cellSize : CGSize {
        get {
            return scrollView.cellSize
        }
        set {
            scrollView.cellSize = newValue
        }
    }
    var maximumZoom : Double {
        get {
            return scrollView.maximumZoom
        }
        set {
            scrollView.maximumZoom = newValue
        }
    }
    var imagePath : String {
        get {
            return scrollView.imagePath
        }
        set {
            scrollView.imagePath = newValue
        }
    }
    
    var imageLoader: ImageLoaderClosure? {
        get {
            return scrollView.imageLoader
        }
        set {
            scrollView.imageLoader = newValue
        }
    }
    
    func resetZoom() {
        scrollView.resetZoom()
    }
}
