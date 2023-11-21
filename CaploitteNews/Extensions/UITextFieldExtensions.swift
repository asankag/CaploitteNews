//
//  UITextFieldExtensions.swift
//  CaploitteNews
//
//  Created by Asanka Gankewala on 11/21/23.
//

import Foundation
import UIKit

extension UITextField {
    
    func setLeftView(image: UIImage) {
      let iconView = UIImageView(frame: CGRect(x: 10, y: 14, width: 16, height: 16)) // set your Own size
      iconView.image = image
      let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 45))
      iconContainerView.addSubview(iconView)
      leftView = iconContainerView
      leftViewMode = .always
      self.tintColor = .lightGray
    }
}
