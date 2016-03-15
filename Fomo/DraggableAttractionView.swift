//
// DraggableAttractionView.swift
// ============================
// ** DEPRECATED **


import UIKit


class DraggableAttractionView: UIView {
    
    let attractionImageView: UIImageView = UIImageView.newAutoLayoutView()
    let contentView: UIView = UIView.newAutoLayoutView()

    var imageOriginalCenter: CGPoint!

    var didSetupConstraints = false

    var attractionImage: UIImage? {
        get { return attractionImageView.image }
        set { attractionImageView.image = newValue }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
        updateConstraints()
    }
    
    override func updateConstraints() {
        if !didSetupConstraints {
            attractionImageView.autoPinEdgesToSuperviewEdges()
            
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    func initSubviews() {
        contentView.frame = bounds
        addSubview(contentView)
        addSubview(attractionImageView)
    }
    
    func translate(view: UIView, sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        let point = sender.locationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            imageOriginalCenter = attractionImageView.center
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            // Drag horizontally
            attractionImageView.center = CGPoint(x: imageOriginalCenter.x + translation.x, y: imageOriginalCenter.y)
            
            // Swipe left, rotate image counterclockwise
            // Swipe right, rotate image clockwise
            var rotationDirection = -1
            // Reverse rotation direction if dragged from bottom half
            if point.y < view.frame.height / 2 {
                rotationDirection = 1
            }

            let angle = translation.x / 10 * CGFloat(rotationDirection)
            let rotationRadians = angle * CGFloat(M_PI) / 180
            attractionImageView.transform = CGAffineTransformRotate(self.transform, rotationRadians)
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            // Swipe right: animate image off screen
            if translation.x > 75 {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.attractionImageView.center = CGPoint(x: 1000, y: self.attractionImageView.center.y)
                })
                
                // TODO: Record like for current user
                print("Like")
                // TODO: Show next card
            }

            // Swipe left: animate image off screen
            else if translation.x < -75 {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.attractionImageView.center = CGPoint(x: -1000, y: self.attractionImageView.center.y)
                })
                
                // TODO: Record dislike for current user
                print("Dislike")
                // TODO: Show next card
            }

            // Restore image original center and transform
            else {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.attractionImageView.center = self.imageOriginalCenter
                    self.attractionImageView.transform = CGAffineTransformIdentity
                })
            }
        }
    }
}
