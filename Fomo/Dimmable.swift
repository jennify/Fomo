//
//  Dimmable.swift
// ============================


import UIKit

protocol Dimmable { }
extension Dimmable where Self: UIViewController {
    
    func dim(withView dimView: UIView) {
        
        view.addSubview(dimView)
        
        dimView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|[dimView]|", options: [], metrics: nil, views: ["dimView": dimView]))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[dimView]|", options: [], metrics: nil, views: ["dimView": dimView]))
        
        UIView.animateWithDuration(0.5) { () -> Void in
            dimView.alpha = 1
        }
    }
    
    func dim(removeView dimView: UIView) {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            dimView.alpha = 0
        }, completion: { (complete) -> Void in
            dimView.removeFromSuperview()
        })
    }
}