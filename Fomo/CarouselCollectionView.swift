// CarouselCollectionView.swift
//
// Copyright (c) 2015 Andrea Bizzotto (bizz84@gmail.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit
import Foundation

/*
 * TODO: Would be nice to support spacing between pages. The link below explains how to do this but
 * the code sample needs to be converted to Auto Layout
 * http://stackoverflow.com/questions/13228600/uicollectionview-align-logic-missing-in-horizontal-paging-scrollview
 */
@objc public protocol CarouselCollectionViewDelegate {
    // method to provide a custom loader for a cell
    func cellClick()
    optional func imageLoaderForCell(atIndexPath indexPath: NSIndexPath, imagePath: String) -> ImageLoaderClosure
//    func carousel(carousel: CarouselCollectionView, didSelectCellAtIndexPath indexPath: NSIndexPath)
//    func carousel(carousel: CarouselCollectionView, didScrollToCellAtIndex cellIndex : NSInteger)
    
}

public class CarouselCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private let reuseID = "Codepath.Fomo.CarouselCell"

    // MARK: Variables
    public var imagePaths : [String] = []
    public var selectDelegate : CarouselCollectionViewDelegate?
    public var currentPageIndex : Int = 0
    public var maximumZoom : Double = 0.0

    // Default clousure used to load images
    public var commonImageLoader: ImageLoaderClosure?

    // Trick to avoid updating the page index more than necessary
    private var clientDidRequestScroll : Bool = false
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.delegate = self
        self.dataSource = self
        
        self.registerClass(CarouselCell.self, forCellWithReuseIdentifier: self.reuseID)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: UICollectionViewDataSource
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imagePaths.count
    }

    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        // Should be set at this point
        assert(commonImageLoader != nil)

        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(self.reuseID, forIndexPath: indexPath) as! CarouselCell
        cell.cellSize = self.bounds.size

        // Pass the closure to the cell
        let imagePath = self.imagePaths[indexPath.row]
        let loader = self.selectDelegate?.imageLoaderForCell?(atIndexPath: indexPath, imagePath: imagePath)
        cell.imageLoader = loader != nil ? loader : self.commonImageLoader
        // Set image path, which will call closure
        cell.imagePath = imagePath
        cell.maximumZoom = maximumZoom
        
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "cellClicked"))

        //self.addGestureRecognizer(cell.scrollView.panGestureRecognizer)

        return cell
    }
    
    func cellClicked() {
        selectDelegate?.cellClick()
    }

    public func collectionView(collectionView : UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {

        if let cell = cell as? CarouselCell {
            self.removeGestureRecognizer(cell.scrollView.panGestureRecognizer)
        }
    }

    // MARK: UICollectionViewDelegateFlowLayout
    public func collectionView(collectionView : UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {

        return self.superview!.bounds.size
    }

    public func collectionView(collectionView : UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //self.selectDelegate?.carousel(self, didSelectCellAtIndexPath: indexPath)
    }

    // MARK: UIScrollViewDelegate
    public func scrollViewDidScroll(scrollView: UIScrollView) {

        if scrollView == self {
            if !self.clientDidRequestScroll {
                self.updatePageIndex()
            }
        }
    }
    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {

        if scrollView == self {
            self.clientDidRequestScroll = false
            self.updatePageIndex()
        }
    }
    public func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {

        if scrollView == self {
            self.clientDidRequestScroll = false
            self.updatePageIndex()
        }
    }

    public func updatePageIndex() {
        let pageIndex = self.getPageNumber()
        if currentPageIndex != pageIndex {
            currentPageIndex = pageIndex
            //self.selectDelegate?.carousel(self, didScrollToCellAtIndex: pageIndex)
        }
    }

    public func getPageNumber() -> NSInteger {

        // http://stackoverflow.com/questions/4132993/getting-the-current-page
        let width : CGFloat = self.frame.size.width
        var page : NSInteger = NSInteger((self.contentOffset.x + (CGFloat(0.5) * width)) / width)
        let numPages = self.numberOfItemsInSection(0)
        if page < 0 {
            page = 0
        }
        else if page >= numPages {
            page = numPages - 1
        }
        return page
    }

    public func setCurrentPageIndex(pageIndex: Int, animated: Bool) {
        self.currentPageIndex = pageIndex
        self.clientDidRequestScroll = true;

        let indexPath = NSIndexPath(forRow: currentPageIndex, inSection: 0)
        self.scrollToItemAtIndexPath(indexPath, atScrollPosition:UICollectionViewScrollPosition.CenteredHorizontally, animated: animated)
    }


    public func resetZoom() {
        for cell in self.visibleCells() as! [CarouselCell] {
            cell.resetZoom()
        }
    }
}
