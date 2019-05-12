//
//  DetailMainCell.swift
//  Store
//
//  Created by 양혜리 on 12/05/2019.
//  Copyright © 2019 hryang. All rights reserved.
//

import UIKit

class DetailMainCell: UITableViewCell {

    @IBOutlet weak var imageCollection: UICollectionView!
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var sellerNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var webBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    
    var datailStore: StoreInfo? {
        didSet {
            if let store = datailStore {
                appNameLabel.text = store.trackName
                sellerNameLabel.text = store.sellerName
                priceLabel.text = "\(store.price) 원"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        webBtn.layer.borderColor = UIColor(red: 161.0/255.0, green: 161.0/255.0, blue: 161.0/255.0, alpha:1.0).cgColor
        webBtn.layer.borderWidth = 1.0
        webBtn.roundedCorners(left: true)
        webBtn.titleLabel?.textColor = .black
        webBtn.titleLabel?.font = .systemFont(ofSize: 14.0)
        
        shareBtn.layer.borderColor = UIColor(red: 161.0/255.0, green: 161.0/255.0, blue: 161.0/255.0, alpha:1.0).cgColor
        shareBtn.layer.borderWidth = 1.0
        shareBtn.roundedCorners(left: false)
        shareBtn.titleLabel?.textColor = .black
        shareBtn.titleLabel?.font = .systemFont(ofSize: 14.0)
        
        appNameLabel.textColor = .black
        appNameLabel.font = .boldSystemFont(ofSize: 21.0)
        
        sellerNameLabel.textColor = UIColor(red: 121.0/255.0, green: 121.0/255.0, blue: 121.0/255.0, alpha:1.0)
        sellerNameLabel.font = .systemFont(ofSize: 17.0)
        
        priceLabel.textColor = .black
        priceLabel.font = .boldSystemFont(ofSize: 18.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        appNameLabel.text = ""
        sellerNameLabel.text = ""
        priceLabel.text = ""
        webBtn.titleLabel?.text = "웹에서 보기"
        shareBtn.titleLabel?.text = "공유하기"
    }
    
    @IBAction func pressedWebButton(_ sender: UIButton) {
    }
    
    @IBAction func pressedShareButton(_ sender: UIButton) {
    }
}
