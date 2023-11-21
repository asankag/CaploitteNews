//
//  ButtonExtensions.swift
//  CaploitteNews
//
//  Created by Asanka Gankewala on 11/21/23.
//

import Foundation
import UIKit

extension UIButton {
    
    func roundAllCorners(radius: CGFloat){
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func dropShadow(){
        layer.cornerRadius = 20
        layer.masksToBounds = false
        layer.shadowRadius = 20.0
        layer.shadowOpacity = 0.4
        layer.shadowColor = Constants.Colors.PrimaryColor.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 2)

    }
}
