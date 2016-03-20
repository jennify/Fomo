//
//  CityCell.swift
// ============================


import UIKit


class CityCell: UITableViewCell {
    
    let cityImageView: UIImageView = UIImageView.newAutoLayoutView()
    let cityName: UILabel = UILabel.newAutoLayoutView()
    let gradient: CAGradientLayer = CAGradientLayer()
        
    var didSetupConstraints = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initViews()
        updateConstraints()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initViews()
        updateConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = self.bounds
    }
    
    override func updateConstraints() {
        if !didSetupConstraints {
            cityImageView.autoPinEdgesToSuperviewEdges()
            cityName.autoCenterInSuperview()
            
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
    
    func initViews() {
        self.clipsToBounds = true
        
        cityName.textColor = UIColor.fomoWhite()
        
        gradient.colors = [UIColor.clearColor().CGColor, UIColor.darkGrayColor().CGColor]
        gradient.opacity = 0.6
        
        cityImageView.layer.insertSublayer(gradient, atIndex: 0)
        
        addSubview(cityImageView)
        addSubview(cityName)
    }
    
    func zoomInCityImage() {
        UIView.animateWithDuration(5) { () -> Void in
            self.cityImageView.transform = CGAffineTransformMakeScale(1.5, 1.5)
        }
    }
    
    func zoomOutCityImage() {
        UIView.animateWithDuration(5) { () -> Void in
            self.cityImageView.transform = CGAffineTransformIdentity
        }
    }
    
    func resetCityImage() {
        self.cityImageView.transform = CGAffineTransformIdentity
    }
}
