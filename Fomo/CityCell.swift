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
            cityName.autoPinEdgeToSuperviewEdge(.Left, withInset: 10)
            cityName.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 10)
            
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
    
    func initViews() {
        cityName.textColor = UIColor.whiteColor()
        
        gradient.colors = [UIColor.clearColor().CGColor, UIColor.blackColor().CGColor]
        gradient.opacity = 0.6
        
        cityImageView.layer.insertSublayer(gradient, atIndex: 0)
        
        addSubview(cityImageView)
        addSubview(cityName)
    }
}
