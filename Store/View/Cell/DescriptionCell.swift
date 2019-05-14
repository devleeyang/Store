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
        descriptionLabel.textColor = .black
        descriptionLabel.font = .systemFont(ofSize: 15.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        descriptionLabel.textColor = .black
        descriptionLabel.font = .systemFont(ofSize: 15.0)
        descriptionLabel.text = ""
        descriptionLabel.backgroundColor = .clear
        descriptionLabel.textAlignment = .center
        topView.backgroundColor = .white
    }
}
