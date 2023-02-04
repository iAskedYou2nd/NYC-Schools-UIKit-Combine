//
//  UIColorUtility.swift
//  NYCSchoolsWithCombine
//
//  Created by iAskedYou2nd on 2/4/23.
//

import UIKit

extension UIColor {
    
    static func | (lightModeColor: UIColor, darkModeColor: UIColor) -> UIColor {
        return UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .light ? lightModeColor : darkModeColor
        }
    }
    
}
