//
//  OnboardingContentViewController.swift
// ======================================


import UIKit

let bounds: CGRect = UIScreen.mainScreen().bounds

class OnboardingContentViewController: UIViewController {
    let kDefaultOnboardingFont: String = "AppleSDGothicNeo-Light"
    let kDefaultTextColor: UIColor = UIColor.whiteColor()
    let kContentWidthMultiplier: CGFloat = 0.9
    let kDefaultImageViewSize: CGFloat = 0
    let kDefaultTopPadding: CGFloat = 80
    let kDefaultUnderIconPadding: CGFloat = 30
    let kDefaultUnderTitlePadding: CGFloat = 30
    let kDefaultBottomPadding: CGFloat = -10
    let kDefaultTitleFontSize: CGFloat = 38
    let kDefaultBodyFontSize: CGFloat = 28
    let kDefaultActionButtonHeight: CGFloat = 50
    let kDefaultMainPageControlHeight: CGFloat = 50
    let page: Int
    let titleText: String
    let body: String
    let backgroundImage: UIImage
    let gifName: String
    let image: UIImage
    let buttonText: String
    let action: dispatch_block_t?
    
    var iconSize: CGFloat
    var fontName: String
    var titleFontSize: CGFloat
    var bodyFontSize: CGFloat
    var topPadding: CGFloat
    var underIconPadding: CGFloat
    var underTitlePadding: CGFloat
    var bottomPadding: CGFloat
    var titleTextColor: UIColor
    var bodyTextColor: UIColor
    var buttonTextColor: UIColor
    
    let kBackgroundMaskAlpha: CGFloat = 0.6
    var shouldMaskBackground: Bool = false
    var shouldBlurBackground: Bool = false
    
    init(page: Int?, title: String?, body: String?, backgroundImage: UIImage?, gifName: String?, image: UIImage?, buttonText: String?, action: dispatch_block_t?) {
        // setup the optional initializer parameters if they were passed in or not
        self.page = page != nil ? page! : Int()
        self.titleText = title != nil ? title! : String()
        self.body = body != nil ? body! : String()
        self.backgroundImage = backgroundImage != nil ? backgroundImage! : UIImage()
        self.gifName = gifName != nil ? gifName! : String()
        self.image = image != nil ? image! : UIImage()
        self.buttonText = buttonText != nil ? buttonText! : String()
        self.action = action != nil ? action : {}
        
        // setup the initial default properties
        self.iconSize = kDefaultImageViewSize
        self.fontName = kDefaultOnboardingFont
        self.titleFontSize = kDefaultTitleFontSize
        self.bodyFontSize = kDefaultBodyFontSize
        self.topPadding = kDefaultTopPadding
        self.underIconPadding = kDefaultUnderIconPadding
        self.underTitlePadding = kDefaultUnderTitlePadding
        self.bottomPadding = kDefaultBottomPadding
        self.titleTextColor = kDefaultTextColor
        self.bodyTextColor = kDefaultTextColor
        self.buttonTextColor = kDefaultTextColor
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateView()
    }
    
    func generateView() {
        
        // set up background
        let backgroundImageView: UIImageView = UIImageView(image: backgroundImage)
        backgroundImageView.frame = UIScreen.mainScreen().bounds
        backgroundImageView.clipsToBounds = true
        backgroundImageView.contentMode = .ScaleAspectFill
        self.view.addSubview(backgroundImageView)
        
        var backgroundMaskView = UIView()
        if shouldMaskBackground {
            backgroundMaskView = UIView(frame: self.view.frame)
            backgroundMaskView.backgroundColor = UIColor(white: 0.0, alpha: kBackgroundMaskAlpha)
            self.view.addSubview(backgroundMaskView)
        }
        
        var blurView = UIVisualEffectView()
        if shouldBlurBackground {
            blurView = UIVisualEffectView(frame: self.view.frame)
            blurView.effect = UIBlurEffect(style: .Light)
            backgroundImageView.addSubview(blurView)
        }
     
        self.view.sendSubviewToBack(backgroundImageView)
        self.view.sendSubviewToBack(backgroundMaskView)
        
        // set up gif
        let filePath = NSBundle.mainBundle().pathForResource(self.gifName, ofType: "gif")
        let gif = NSData(contentsOfFile: filePath!)
        let webViewBG = UIWebView()
        webViewBG.loadData(gif!, MIMEType: "image/gif", textEncodingName: String(), baseURL: NSURL())
        webViewBG.scalesPageToFit = true
        webViewBG.contentMode = .ScaleAspectFit
        webViewBG.userInteractionEnabled = false
        self.view.addSubview(webViewBG)

        // do some calculation for some values we'll need to reuse, namely the width of the view,
        // the center of the width, and the content width we want to fill up, which is some
        // fraction of the view width we set in the multipler constant
        let viewWidth: CGFloat = CGRectGetWidth(self.view.frame)
        let horizontalCenter: CGFloat = viewWidth / 2
        let contentWidth: CGFloat = viewWidth * kContentWidthMultiplier
        
        // create the image view with the appropriate image, size, and center in on screen
        let imageView: UIImageView = UIImageView(image: self.image)
        imageView.frame = CGRectMake(horizontalCenter - (self.iconSize / 2), self.topPadding, self.iconSize, self.iconSize)
        self.view.addSubview(imageView)
        
        let titleLabel: UILabel = UILabel(frame: CGRectMake(0, CGRectGetMaxY(imageView.frame) + self.underIconPadding, contentWidth, 0))
        titleLabel.text = self.titleText
        titleLabel.font = UIFont(name: self.fontName, size: self.titleFontSize)
        titleLabel.textColor = self.titleTextColor
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .Center
        titleLabel.sizeToFit()
        titleLabel.center = CGPointMake(horizontalCenter, titleLabel.center.y)
        self.view.addSubview(titleLabel)
        
        let bodyLabel: UILabel = UILabel(frame: CGRectMake(0, CGRectGetMaxY(titleLabel.frame) + self.underTitlePadding, contentWidth, 0))
        bodyLabel.text = self.body
        bodyLabel.font = UIFont(name: self.fontName, size: self.bodyFontSize)
        bodyLabel.textColor = self.titleTextColor
        bodyLabel.numberOfLines = 0
        bodyLabel.textAlignment = .Center
        bodyLabel.sizeToFit()
        bodyLabel.center = CGPointMake(horizontalCenter, bodyLabel.center.y)
        self.view.addSubview(bodyLabel)
        
        if (self.buttonText.characters.count != 0) {
            let actionButton: UIButton = UIButton(frame: CGRectMake((CGRectGetMaxX(self.view.frame) / 2) - (contentWidth / 2), CGRectGetMaxY(self.view.frame) - kDefaultMainPageControlHeight - kDefaultActionButtonHeight - self.bottomPadding, contentWidth, kDefaultActionButtonHeight))
            actionButton.titleLabel?.font = UIFont .systemFontOfSize(24)
            actionButton.setTitle(self.buttonText, forState: .Normal)
            actionButton.setTitleColor(self.buttonTextColor, forState: .Normal)
            actionButton.addTarget(self, action: "handleButtonPressed", forControlEvents: .TouchUpInside)
            self.view.addSubview(actionButton)
        }
        
        // hardcoded dimensions to fit 6+
        if self.page == 1 {
            titleLabel.textColor = UIColor(red: 33/255, green: 38/255, blue: 45/255, alpha: 0.7)
            bodyLabel.textColor = UIColor(red: 33/255, green: 38/255, blue: 45/255, alpha: 0.7)
            
            blurView = UIVisualEffectView(frame: self.view.frame)
            blurView.effect = UIBlurEffect(style: .ExtraLight)
            backgroundImageView.addSubview(blurView)
            
            webViewBG.frame = CGRect(x: 0, y: 325, width: bounds.size.width, height: 265)
        }
        if self.page == 2 {
            titleLabel.textColor = UIColor(red: 56/255, green: 52/255, blue: 51/255, alpha: 0.7)
            bodyLabel.textColor = UIColor(red: 56/255, green: 52/255, blue: 51/255, alpha: 0.7)
            
            blurView = UIVisualEffectView(frame: self.view.frame)
            blurView.effect = UIBlurEffect(style: .ExtraLight)
            backgroundImageView.addSubview(blurView)
            
            webViewBG.frame = CGRect(x: 0, y: 325, width: bounds.size.width, height: 265)
        }
        if self.page == 3 {
            titleLabel.textColor = UIColor(red: 33/255, green: 42/255, blue: 53/255, alpha: 0.7)
            bodyLabel.textColor = UIColor(red: 33/255, green: 42/255, blue: 53/255, alpha: 0.7)
            
            webViewBG.frame = CGRect(x: 0, y: 240, width: bounds.size.width, height: bounds.size.height)
        }
    }
    
    func handleButtonPressed() {
        self.action!()
    }
}
