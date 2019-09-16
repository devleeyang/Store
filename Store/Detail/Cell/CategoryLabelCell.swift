//
//  CategoryLabelCell.swift
//  Store
//
//  Created by 양혜리 on 16/09/2019.
//  Copyright © 2019 hryang. All rights reserved.
//

import UIKit

class CategoryLabelCell: UICollectionViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        categoryLabel.text = ""
    }
}
