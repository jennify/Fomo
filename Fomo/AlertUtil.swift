//
// AlertUtil.swift
// ============================


import Foundation
import AMTumblrHud


func displayAlert(vc: UIViewController, error: NSError) {
    let alertView = UIAlertController(title: "Error", message: error.description, preferredStyle: UIAlertControllerStyle.Alert)
    alertView.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
    vc.presentViewController(alertView, animated:false, completion:nil)
}

func displayHUD(view: UIView) -> AMTumblrHud {
    let hud = AMTumblrHud()
    hud.hudColor = UIColor.redColor()
    view.addSubview(hud)
    hud.autoPinEdgesToSuperviewEdges()
    hud.showAnimated(true)
    return hud
}

func prettyPrintError(error: NSError!) {
    print("Pretty Print Error: ")
    print(error.code)
}

func sendFriendInviteToItinerary(vc: UIViewController, shareMessage: String?, itinerary: Itinerary) {
    var message = "You've been invited! "
    if shareMessage != nil {
        message = shareMessage!
    } else {
        message += "Let me know if you're joining us in \(itinerary.city!.name!) on the link."
    }
    
    let objectsToShare = [message, "fomorecommender.herokuapp.com"]
    let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
    activityVC.view.center = vc.view.center
    
    activityVC.excludedActivityTypes = [
        UIActivityTypeAirDrop,
        UIActivityTypeAddToReadingList,
        UIActivityTypeAssignToContact,
        UIActivityTypeMail,
        UIActivityTypeOpenInIBooks,
        UIActivityTypePostToFlickr,
        UIActivityTypePostToVimeo,
        UIActivityTypePrint,
    ]
    vc.presentViewController(activityVC, animated: true, completion: nil)
    
}

extension UIFont {
    class func fomoH1() -> UIFont {
        return UIFont(name: "AppleSDGothicNeo-Light", size: 20)!
    }
    class func fomoH2() -> UIFont {
        return UIFont(name: "AppleSDGothicNeo-Light", size: 18)!
    }
    class func fomoH3() -> UIFont {
        return UIFont(name: "AppleSDGothicNeo-Light", size: 16)!
    }
    class func fomoParagraph() -> UIFont {
        return UIFont(name: "AppleSDGothicNeo-Light", size: 14)!
    }
    class func fomoSized(size: CGFloat) -> UIFont {
        return UIFont(name: "AppleSDGothicNeo-Light", size: size)!
    }
    
    class func fomoBold(size: CGFloat) -> UIFont {
        return UIFont(name: "AppleSDGothicNeo-Regular", size: size)!
    }
    
    class func fomoBoldest(size: CGFloat) -> UIFont {
        return UIFont(name:"AppleSDGothicNeo-Bold", size: size)!
    }
}

extension UIColor {
    class func initWithHex(hex: String) -> UIColor {
        var int = UInt32()
        NSScanner(string: hex).scanHexInt(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            return UIColor.clearColor()
        }
        return UIColor(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    class func fomoColors(index: Int) -> UIColor {
        let colors = [
            UIColor.initWithHex("367caf"),
            UIColor.initWithHex("89cce9"),
            UIColor.initWithHex("dbe3f6"),
            UIColor.initWithHex("fcfcf4"),
            UIColor.initWithHex("ece0d0"),
            UIColor.initWithHex("ece0d0"),
            UIColor.initWithHex("f5f8fA"),
        ]
        return colors[index]
    }
    
    class func colorsTest(index: Int) -> UIColor {
        let colors1 = [
            UIColor.initWithHex("1e1111"),
            UIColor.initWithHex("b5b6b5"),
            UIColor.initWithHex("ecede8"),
            UIColor.initWithHex("f8f9fc"),
            UIColor.initWithHex("dfdeff"),
        ]
        // Tree branch
        let colors = [
            UIColor.initWithHex("2f2c30"),
            UIColor.initWithHex("61656e"),
            UIColor.initWithHex("bac0ce"),
            UIColor.initWithHex("e9e8e6"),
            UIColor.initWithHex("fbfbf9"),
        ]
        
        return colors[index]
    }
    
    class func fomoBackground() -> UIColor {
        return UIColor.initWithHex("f1f0ef") //UIColor.colorsTest(3)
    }
    
    class func fomoCardBG() -> UIColor {
        return UIColor.colorsTest(4)
    }
    
    class func fomoTextColor() -> UIColor {
        return UIColor.colorsTest(0)
    }
    
    class func fomoHamburgerBGColor() -> UIColor {
        return UIColor.colorsTest(1)
    }
    
    class func fomoHamburgerTextColor() -> UIColor {
        return UIColor.colorsTest(3)
    }
    
    class func fomoHighlight() -> UIColor {
        return UIColor.initWithHex("90E1CE")
    }
    
    class func fomoLight() -> UIColor {
        return UIColor.colorsTest(4)
    }
    
    class func fomoNavBar() -> UIColor {
        return UIColor.fomoLight()
    }
    
    class func fomoNavBarText() -> UIColor {
        return UIColor.colorsTest(4)
    }
    
    
    // All Old fomo colors.
    
    class func fomoBlue() -> UIColor {
        return UIColor.fomoColors(0)
    }
    
    class func fomoTeal() -> UIColor {
        return UIColor.fomoColors(1)
    }
    
    class func fomoPeriwinkle() -> UIColor {
        return UIColor.fomoColors(2)
    }
    
    class func fomoWhite() -> UIColor {
        return UIColor.fomoColors(3)
    }
    
    class func fomoSand() -> UIColor {
        return UIColor.fomoColors(4)
    }
    
    class func fomoGrey() -> UIColor {
        return UIColor.fomoColors(5)
    }
}