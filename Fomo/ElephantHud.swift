//
//  ElephantHud.swift
//  Fomo
//
//  Created by Jennifer Lee on 4/3/16.
//  Copyright © 2016 TeamAwesome. All rights reserved.
//

import Foundation

class ElephantHud: UIView {
    var webViewBG: UIWebView!
    var hudBG: UIView!
    var hudDimBG: UIView!
    var didSetupConstraints = false
    var waitingLabel: UILabel!
    let wittyText: [String] = ["Opening Suitcase", "Folding Shirts", "Storing Toothbrush", "Feeding Cat"]
    var wittyTextIndex = 0
    var timer: NSTimer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
        updateConstraints()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initViews()
        updateConstraints()
    }
    
    func initViews() {
        setUpHUD()
    }
    
    func setUpHUD() {
        let gifName = "elephant"
        let filePath = NSBundle.mainBundle().pathForResource(gifName, ofType: "gif")
        
        // Dimmed view
        hudDimBG = UIView()
        hudDimBG.backgroundColor = UIColor.blackColor()
        hudDimBG.alpha = 0.7
        
        // Circle background
        hudBG = UIView()
        hudBG.backgroundColor = UIColor.whiteColor()
        hudBG.layer.cornerRadius = 100
        hudBG.clipsToBounds = true
        
        // Elephant View
        let gif = NSData(contentsOfFile: filePath!)
        self.webViewBG = UIWebView()
        webViewBG.backgroundColor = UIColor.clearColor()
        webViewBG.loadData(gif!, MIMEType: "image/gif", textEncodingName: String(), baseURL: NSURL())
        webViewBG.scalesPageToFit = true
        webViewBG.contentMode = .ScaleAspectFill
        webViewBG.userInteractionEnabled = false
        
        // Label
        waitingLabel = UILabel()
        waitingLabel.text = wittyText.first
        waitingLabel.textColor = UIColor.darkGrayColor()
        waitingLabel.font = UIFont.fomoH3()
        waitingLabel.sizeToFit()
        
        addSubview(hudDimBG)
        hudBG.addSubview(webViewBG)
        hudBG.addSubview(waitingLabel)
        addSubview(hudBG)
        hudDimBG.alpha = 0
        hudBG.alpha = 0
    }
    
    func startAnimating() {
        hudDimBG.alpha = 0.7
        hudBG.alpha = 1
        timer = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: "onTimer", userInfo: nil, repeats: true)
    }
    
    func stopAnimating() {
        hudDimBG.alpha = 0
        hudBG.alpha = 0
        if timer != nil {
            timer.invalidate()
        }
        
    }
    
    func onTimer() {
        waitingLabel.text = wittyText[wittyTextIndex]
        wittyTextIndex = (wittyTextIndex + 1) % wittyText.count
    }
    
    override func updateConstraints() {
        if !didSetupConstraints {
            // HUD Configuration
            hudDimBG.configureForAutoLayout()
            hudDimBG.autoPinEdgesToSuperviewEdges()
            
            hudBG.configureForAutoLayout()
            hudBG.autoCenterInSuperview()
            hudBG.autoSetDimension(.Width, toSize: 200)
            hudBG.autoSetDimension(.Height, toSize: 200)
            
            // Elephant View
            webViewBG.configureForAutoLayout()
            webViewBG.autoAlignAxisToSuperviewAxis(.Vertical)
            webViewBG.autoAlignAxis(.Horizontal, toSameAxisOfView: hudBG, withOffset: -20)
            webViewBG.autoSetDimension(.Width, toSize: 120)
            webViewBG.autoSetDimension(.Height, toSize: 100)
            
            waitingLabel.configureForAutoLayout()
            waitingLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: webViewBG, withOffset: 8)
            waitingLabel.autoAlignAxisToSuperviewAxis(.Vertical)
        }
        super.updateConstraints()
    }
}
