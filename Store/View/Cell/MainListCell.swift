//
//  MainListCell.swift
//  Store
//
//  Created by 양혜리 on 12/05/2019.
//  Copyright © 2019 hryang. All rights reserved.
//

import UIKit
import MGStarRatingView
import Kingfisher

class MainListCell: UITableViewCell {

    var resultStore: StoreInfo? {
        didSet {
            if let store = resultStore {
                let resource = ImageResource(downloadURL: URL(string: store.artworkUrl512)!, cacheKey: store.artworkUrl512)
                appIcon.kf.setImage(with: resource)
                appName.text = store.trackName
                companyName.text = store.sellerName
                category.text = store.genres.first
                price.text = "\(store.formattedPrice)"
                starView.current = CGFloat(store.averageUserRating ?? 0)
            }
        }
    }
    
    @IBOutlet weak var appIcon: UIImageView!
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var starView: StarRatingView!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backGroundView.layer.borderColor = UIColor(red: 222.0/255.0, green: 222.0/255.0, blue: 222.0/255.0, alpha:1.0).cgColor
        backGroundView.layer.borderWidth = 1.0
        backGroundView.layer.cornerRadius = 4.0
        
        appIcon.roundedCorners(top: true)
        
        appName.textColor =  UIColor(red: 88.0/255.0, green: 88.0/255.0, blue: 88.0/255.0, alpha:1.0)
        appName.font = .systemFont(ofSize: 16.0)
        appName.textAlignment = .left
        
        companyName.textColor =  UIColor(red: 191.0/255.0, green: 191.0/255.0, blue: 191.0/255.0, alpha:1.0)
        companyName.font = .systemFont(ofSize: 14.0)
        companyName.textAlignment = .left
        
        category.textColor =  UIColor(red: 101.0/255.0, green: 101.0/255.0, blue: 101.0/255.0, alpha:1.0)
        category.font = .systemFont(ofSize: 14.0)
        category.textAlignment = .left
        
        price.textColor =  UIColor(red: 96.0/255.0, green: 96.0/255.0, blue: 96.0/255.0, alpha:1.0)
        price.font = .systemFont(ofSize: 14.0)
        price.textAlignment = .left
        
        let attribute = StarRatingAttribute(type: .rate,
                                            point: 14,
                                            spacing: 4,
                                            emptyColor: UIColor(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha:1.0),
                                            fillColor: .yellow,
                                            emptyImage: nil,
                                            fillImage: nil)
        starView.configure(attribute, current: 0, max: 5)
        
        self.backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        backGroundView.layer.cornerRadius = 0
        backGroundView.layer.mask = nil
        appIcon.layer.cornerRadius = 0
        appIcon.layer.mask = nil
        appIcon.image = nil
        appName.text = ""
        companyName.text = ""
        starView.emptyImage = nil
        category.text = ""
        price.text = ""
    }
}
