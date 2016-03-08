//
//  AlertUtil.swift
//  Fomo
//
//  Created by Jennifer Lee on 3/4/16.
//  Copyright © 2016 TeamAwesome. All rights reserved.
//

import Foundation


func displayAlert(vc: UIViewController , error: NSError) {
    let alertView = UIAlertController(title: "Error", message: error.description, preferredStyle: UIAlertControllerStyle.Alert)
    alertView.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
    vc.presentViewController(alertView, animated:false, completion:nil)
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
        ]
        return colors[index]
    }
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

    
}