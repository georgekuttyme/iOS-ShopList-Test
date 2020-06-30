//
//  FontExtensions.swift
//  Shop-List
//
//  Created by Legends on 27/06/20.
//  Copyright © 2020 Legends. All rights reserved.
//

import UIKit
///     Declared common font sizes
let smallFontSize: CGFloat   = 12.0
let normalFontSize: CGFloat  = 14.0
let bigFontSize: CGFloat     = 16.0
extension UIFont {
    
///     Defined the common fonts used in entire applications
///     Params: size in Cgfloat
///     Return: UIFont with specified size
    
    class func appRegularFont(size: CGFloat = normalFontSize) -> UIFont {
        return UIFont(name: "Helvetica", size: size)!
    }

    class func appMediumFont(size: CGFloat = normalFontSize) -> UIFont {
        return UIFont(name: "Helvetica-SemiBold", size: size)!
    }

    class func appBoldFont(size: CGFloat =  normalFontSize) -> UIFont {
        return UIFont(name: "Helvetica-Bold", size: size)!
    }
}
