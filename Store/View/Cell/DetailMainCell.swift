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
    @IBOutlet weak var buttonBackView: UIView!
    
    var datailStore: StoreInfo? {
        didSet {
            if let store = datailStore {
                appNameLabel.text = store.trackName
                sellerNameLabel.text = store.sellerName
                priceLabel.text = "\(store.price) 원"
                webBtn.titleLabel?.text = "웹에서 보기"
                shareBtn.titleLabel?.text = "공유하기"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        webBtn.titleLabel?.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        webBtn.titleLabel?.font = .systemFont(ofSize: 14.0)
    
        shareBtn.titleLabel?.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        shareBtn.titleLabel?.font = .systemFont(ofSize: 14.0)
        shareBtn.layer.addBorder(edge: .left, color: #colorLiteral(red: 0.631372549, green: 0.631372549, blue: 0.631372549, alpha: 0.74), thickness: 1.0)
        
        appNameLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        appNameLabel.font = .boldSystemFont(ofSize: 21.0)
        
        sellerNameLabel.textColor = #colorLiteral(red: 0.4745098039, green: 0.4745098039, blue: 0.4745098039, alpha: 0.74)
        sellerNameLabel.font = .systemFont(ofSize: 17.0)
        
        priceLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        priceLabel.font = .boldSystemFont(ofSize: 18.0)
        
        buttonBackView.layer.borderWidth = 1.0
        buttonBackView.layer.borderColor = #colorLiteral(red: 0.631372549, green: 0.631372549, blue: 0.631372549, alpha: 0.74).cgColor
        buttonBackView.layer.cornerRadius = 4
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
}
