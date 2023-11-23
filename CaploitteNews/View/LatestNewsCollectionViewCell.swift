//
//  LatestNewsCollectionViewCell.swift
//  CaploitteNews
//
//  Created by Asanka Gankewala on 11/22/23.
//

import UIKit
import SDWebImage

class LatestNewsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellDescription: UILabel!
    @IBOutlet weak var cellTopic: UILabel!
    @IBOutlet weak var cellAuther: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    static let identifer = "LatestNewsCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        cellImage.layer.cornerRadius = 10
    }
    
    public func latestNewsCellRegister(imageName: String, auther: String, topic: String, description: String) {
        cellImage.sd_setImage(with: URL(string: imageName), placeholderImage: UIImage(named: "promotion-background"))
        cellAuther.text = "By \(auther)"
        cellTopic.text = topic
        cellDescription.text = description
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "LatestNewsCollectionViewCell", bundle: nil)
    }

}
