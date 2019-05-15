//
//  DescriptionCell.swift
//  Store
//
//  Created by 양혜리 on 12/05/2019.
//  Copyright © 2019 hryang. All rights reserved.
//

import UIKit

class DescriptionCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var topView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        descriptionLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        descriptionLabel.font = .systemFont(ofSize: 15.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        descriptionLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        descriptionLabel.font = .systemFont(ofSize: 15.0)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text = ""
        descriptionLabel.backgroundColor = .clear
        descriptionLabel.textAlignment = .center
        topView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        topView.alpha = 0
        topView.clipsToBounds = true
    }
}
