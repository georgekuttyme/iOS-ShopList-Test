//
//  ColorExtensions.swift
//  Shop-List
//
//  Created by Legends on 27/06/20.
//  Copyright © 2020 Legends. All rights reserved.
//

import UIKit

extension UIColor {

///     Navy Blue - App theme colour
    class func appThemeColor() -> UIColor {
        return UIColor.fromHex(hex: "04c2b8")
    }

///     White - background color
    class func appWhiteColor() -> UIColor {
        return UIColor.white
    }
   
///     black - Dark text color "#0a1f44"
    class func appBlackColor() -> UIColor {
        return UIColor.fromHex(hex: "#0a1f44")
    }

///     Gray Color #8A94A6
    class func appGrayColor() -> UIColor {
        return UIColor.fromHex(hex: "#8A94A6")
    }

///     Method for convert hexa colour code to UIColour
///     Parameter - Hexa colour code in String
///     Return - UIColor
    class func fromHex(hex: String) -> UIColor {
           var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

           if cString.hasPrefix("#") {
               cString.remove(at: cString.startIndex)
           }

           if (cString.count) != 6 {
               return UIColor.gray
           }

           var rgbValue: UInt64 = 0
           Scanner(string: cString).scanHexInt64(&rgbValue)

           return UIColor(
               red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
               green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
               blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
               alpha: CGFloat(1.0)
           )
       }
}
