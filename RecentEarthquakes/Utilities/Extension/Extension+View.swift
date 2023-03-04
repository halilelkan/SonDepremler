//
//  Extension+View.swift
//  RecentEarthquakes
//
//  Created by Halil İbrahim Elkan on 26.02.2023.
//

import Foundation
import UIKit

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    @IBInspectable
    var ladius: CGFloat {
        set {
//            layer. = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
}
