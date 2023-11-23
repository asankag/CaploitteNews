//
//  NewsTableViewCell.swift
//  CaploitteNews
//
//  Created by Asanka Gankewala on 11/22/23.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    static let identifer = "NewsTableViewCell"
    
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var cellTitel: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        cellImage.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func registorCell (image: String, author: String, titel: String, datetime: String) {
        cellImage.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "promotion-background"))
        authorLabel.text = author
        cellTitel.text = titel
        dateTimeLabel.text = datetime
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "NewsTableViewCell", bundle: nil)
    }
    
}
