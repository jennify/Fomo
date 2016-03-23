//
//  CarouselCellScrollView.swift
// ============================


import UIKit

// Image loader closure type
public typealias ImageLoaderClosure = ((imageView: UIImageView, imagePath : String, completion: (newImage: Bool) -> ()) -> ())

class CarouselCellScrollView: UIScrollView, UIScrollViewDelegate {
    
    let MaximumZoom = 4.0
    
    var cellSize : CGSize = CGSizeZero
    var maximumZoom = 0.0
    var imagePath : String = "" {
        didSet {
            assert(self.imageLoader != nil, "Image loader must be specified")
            self.imageLoader?(imageView : self.imageView, imagePath: imagePath, completion: {
                (newImage) in
                self.resetZoom()
            })
        }
    }
    var imageLoader: ImageLoaderClosure?
    
    var imageView : UIImageView = UIImageView.newAutoLayoutView()
    var didSetupConstraints = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.delegate = self
        
        initViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.delegate = self
        
        initViews()
    }
    
    func initViews() {
        imageView.contentMode = .ScaleAspectFill
        addSubview(imageView)
    }
    
    func resetZoom() {
        self.contentInset = UIEdgeInsetsMake(208, 0, 208, 0)
        
        if self.imageView.image == nil {
            return
        }
        let imageSize = self.imageView.image!.size
        
        // nothing to do if image is not set
        if CGSizeEqualToSize(imageSize, CGSizeZero) {
            return
        }
        
        // Stack overflow people suggest this, not sure if it applies to us
        self.imageView.contentMode = UIViewContentMode.Center
        if cellSize.width > imageSize.width && cellSize.height > imageSize.height {
            self.imageView.contentMode = UIViewContentMode.ScaleAspectFit
        }
        
        let cellAspectRatio : CGFloat = self.cellSize.width / self.cellSize.height
        let imageAspectRatio : CGFloat = imageSize.width / imageSize.height
        let cellAspectRatioWiderThanImage = cellAspectRatio > imageAspectRatio
        
        // Calculate Zoom
        // If image is taller, then make edge to edge height, else make edge to edge width
        let zoom = cellAspectRatioWiderThanImage ? cellSize.height / imageSize.height : cellSize.width / imageSize.width
        
        self.maximumZoomScale = zoom * CGFloat(zoomToUse())
        self.minimumZoomScale = zoom
        self.zoomScale = zoom
        
        // Update content inset
        let adjustedContentWidth = cellSize.height * imageAspectRatio
        let horzContentInset = cellAspectRatioWiderThanImage ? 0.5 * (cellSize.width - adjustedContentWidth) : 0.0
        let adjustedContentHeight = cellSize.width / imageAspectRatio
        let vertContentInset = !cellAspectRatioWiderThanImage ? 0.5 * (cellSize.height - adjustedContentHeight) : 0.0
        
        self.imageView.contentMode = UIViewContentMode.ScaleAspectFill
        self.contentInset = UIEdgeInsetsMake(vertContentInset, horzContentInset, vertContentInset, horzContentInset)
    }
    
    func zoomToUse() -> Double {
        return maximumZoom < 1.0 ? MaximumZoom : maximumZoom
    }
    
    func viewForZoomingInScrollView(scrollView : UIScrollView) -> UIView? {
        return self.imageView
    }
}
