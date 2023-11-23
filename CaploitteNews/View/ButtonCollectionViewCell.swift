//
//  ButtonCollectionViewCell.swift
//  CaploitteNews
//
//  Created by Asanka Gankewala on 11/22/23.
//

import UIKit

class ButtonCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var cellBgView: UIView!
    static let identifer = "ButtonCollectionViewCell"
    
    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var cellTextLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func setButton (name :String, status:Bool) {
        
        var itemSize = name.size(withAttributes: [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 25)
        ])
        if itemSize.width <= 50 {
            itemSize.width = 80
        }
        print (itemSize)
        cellWidthConstraint.constant = itemSize.width
        cellTextLabel.text = name
        cellTextLabel.textColor = .black
        cellBgView.backgroundColor = .white
        cellBgView.layer.cornerRadius = 15
        // Apply a shadow
        layer.cornerRadius = 10
        layer.masksToBounds = false
        layer.shadowRadius = 8.0
        layer.shadowOpacity = 0.10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        
        if status {
            cellBgView.backgroundColor = Constants.Colors.PrimaryColor
            cellTextLabel.textColor = .white
        } else {
            cellBgView.backgroundColor = .white
            cellTextLabel.textColor = .black
        }
        
        if name == "Filter" {
            leftImage.isHidden = false
            cellBgView.backgroundColor = Constants.Colors.PrimaryColor
            cellTextLabel.textColor = .white
        } else {
            leftImage.isHidden = true
        }
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "ButtonCollectionViewCell", bundle: nil)
    }
    
    override var isSelected: Bool{
        didSet{
            if self.isSelected {
                cellBgView.backgroundColor = Constants.Colors.PrimaryColor
                cellTextLabel.textColor = .white
            }
            else {
                cellBgView.backgroundColor = .white
                cellTextLabel.textColor = .black
            }
        }
    }
}
