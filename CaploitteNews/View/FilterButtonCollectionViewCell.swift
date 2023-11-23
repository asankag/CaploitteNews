//
//  FilterButtonCollectionViewCell.swift
//  CaploitteNews
//
//  Created by Asanka Gankewala on 11/23/23.
//

import UIKit

class FilterButtonCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cellWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var cellBgView: UIView!
    @IBOutlet weak var cellText: UILabel!
    
    static let identifer = "FilterButtonCollectionViewCell"
    
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
        cellText.text = name
        cellText.textColor = .black
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
            cellText.textColor = .white
        } else {
            cellBgView.backgroundColor = .white
            cellText.textColor = .black
        }
    }
    
    override var isSelected: Bool{
        didSet{
            if self.isSelected {
                cellBgView.backgroundColor = Constants.Colors.PrimaryColor
                cellText.textColor = .white
            }
            else {
                cellBgView.backgroundColor = .white
                cellText.textColor = .black
            }
        }
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "FilterButtonCollectionViewCell", bundle: nil)
    }

}
