//
//  NewsDetailViewController.swift
//  CaploitteNews
//
//  Created by Asanka Gankewala on 11/22/23.
//

import Foundation
import UIKit
import SDWebImage

class NewsDetailViewController: UIViewController {
    
    @IBOutlet weak var detailViewImage: UIImageView!
    @IBOutlet weak var detailViewBottomView: UIView!
    @IBOutlet weak var detailViewCenterView: UIView!
    @IBOutlet weak var newsContent: UITextView!
    @IBOutlet weak var dateTimeTextLabel: UILabel!
    var theNewsItem: Articles?
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var titelTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        UiChanges()
    }
    
    func UiChanges() {
        
        detailViewBottomView.layer.cornerRadius = 20
        
//        let blurEffect = UIBlurEffect(style: .light)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = CGRect(x: 0, y: 0, width: detailViewCenterView.frame.width, height: detailViewCenterView.frame.height)
//
//        detailViewCenterView.addSubview(blurEffectView)
//        detailViewCenterView.cornerRadius()
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
//        var roundRect = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 100, height: 100), byRoundingCorners:.allCorners, cornerRadii: CGSize(width: 16.0, height: 16.0))
        
        blurEffectView.frame = CGRect(x: 0, y: 0, width: detailViewCenterView.frame.width, height: detailViewCenterView.frame.height)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        detailViewCenterView.addSubview(blurEffectView)
        
//        detailViewCenterView.backgroundColor = .yellow
//        detailViewCenterView.layer.cornerRadius = 10
        
        detailViewImage.sd_setImage(with: URL(string: theNewsItem?.urlToImage ?? ""), placeholderImage: UIImage(named: "promotion-background"))
        
        let string = theNewsItem?.publishedAt ?? "2017-01-27T18:36:36Z"
        let isoFormatter = ISO8601DateFormatter()
        let date = isoFormatter.date(from: string)!
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMM yyyy"
        let formattedDateInString = formatter.string(from: date)
        
        titelTextView.text = theNewsItem?.title
        
        publisherLabel.text = formattedDateInString
        dateTimeTextLabel.text = "Published by \(theNewsItem?.author ?? "")"
        newsContent.text = theNewsItem?.content
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
