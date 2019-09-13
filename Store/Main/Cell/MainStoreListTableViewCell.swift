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

class MainStoreListTableViewCell: UITableViewCell {

    var cellModel: MainStoreCellModel? {
        didSet {
            guard let data = cellModel else {
                return
            }
            appName.text = data.name
            companyName.text = data.company
            category.text = data.category
            price.text = data.price
            starView.current = CGFloat(data.averageRating)
            let resource = ImageResource(downloadURL: data.iconURL, cacheKey: data.iconURL.description)
            appIcon.kf.setImage(with: resource)
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
        
        backGroundView.layer.borderColor = #colorLiteral(red: 0.8705882353, green: 0.8705882353, blue: 0.8705882353, alpha: 0.74).cgColor
        backGroundView.layer.borderWidth = 1.0
        backGroundView.layer.cornerRadius = 4.0
        
        appIcon.roundedCorners(top: true)
        
        appName.textColor =  #colorLiteral(red: 0.3450980392, green: 0.3450980392, blue: 0.3450980392, alpha: 0.74)
        appName.font = .systemFont(ofSize: 16.0)
        appName.textAlignment = .left
        
        companyName.textColor =  #colorLiteral(red: 0.7490196078, green: 0.7490196078, blue: 0.7490196078, alpha: 0.74)
        companyName.font = .systemFont(ofSize: 14.0)
        companyName.textAlignment = .left
        
        category.textColor =  #colorLiteral(red: 0.3960784314, green: 0.3960784314, blue: 0.3960784314, alpha: 0.74)
        category.font = .systemFont(ofSize: 14.0)
        category.textAlignment = .left
        
        price.textColor =  #colorLiteral(red: 0.3764705882, green: 0.3764705882, blue: 0.3764705882, alpha: 0.74)
        price.font = .systemFont(ofSize: 14.0)
        price.textAlignment = .left
        
        let attribute = StarRatingAttribute(type: .rate,
                                            point: 14,
                                            spacing: 4,
                                            emptyColor: #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 0.74),
                                            fillColor: #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1),
                                            emptyImage: nil,
                                            fillImage: nil)
        starView.configure(attribute, current: 0, max: 5)
        
        backgroundColor = .clear
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
