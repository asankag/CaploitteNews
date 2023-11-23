//
//  ButtonExtensions.swift
//  CaploitteNews
//
//  Created by Asanka Gankewala on 11/21/23.
//

import Foundation
import UIKit

extension UIButton {
    func dropShadow(scale: Double){
        layer.cornerRadius = scale
        layer.masksToBounds = false
        layer.shadowRadius = scale
        layer.shadowOpacity = 0.4
        layer.shadowColor = Constants.Colors.PrimaryColor.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 2)

    }
}
