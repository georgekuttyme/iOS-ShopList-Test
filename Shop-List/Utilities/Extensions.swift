//
//  Extensions.swift
//  Shop-List
//
//  Created by Legends on 27/06/20.
//  Copyright © 2020 Legends. All rights reserved.
//

import Foundation
import UIKit

///    Extending the functionalities of swift Data types
extension String {
///    Calcualte the size of the Sting according with the font size
///    Params: UIFont
///    Return: size of the String in CGSize
    func sizeOfString(withFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }
}
