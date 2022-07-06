//
//  UIColor+Extensions.swift
//  WebMotorsChallenge
//
//  Created by Gustavo Henriques on 29/06/22.
//

import Foundation
import UIKit

extension UIColor {
    static var primaryColor: UIColor = {
        
        let light: UIColor = .white
        
        let dark = UIColor(red: 0.24, green: 0.24, blue: 0.24, alpha: 1.00)
                
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    return dark
                } else {
                    return light
                }
            }
        } else {
            return light
        }
    }()
}
