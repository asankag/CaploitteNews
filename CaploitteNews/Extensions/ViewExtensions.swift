//
//  ViewExtensions.swift
//  CaploitteNews
//
//  Created by Asanka Gankewala on 11/22/23.
//

import Foundation
import UIKit

extension UIView {
    
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
        layer.cornerRadius = 10
    }
    
    func cornerRadius(scale: Bool = true) {
        layer.masksToBounds = false
        layer.cornerRadius = 10
    }
}
