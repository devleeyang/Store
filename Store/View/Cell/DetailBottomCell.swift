//
//  DetailBottomCell.swift
//  Store
//
//  Created by 양혜리 on 12/05/2019.
//  Copyright © 2019 hryang. All rights reserved.
//

import UIKit

class DetailBottomCell: UITableViewCell {

    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var arrow: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        leftLabel.textColor = UIColor(red: 36.0/255.0, green: 36.0/255.0, blue: 36.0/255.0, alpha:1.0)
        leftLabel.font = .systemFont(ofSize: 15.0)
        
        rightLabel.textColor = UIColor(red: 43.0/255.0, green: 166.0/255.0, blue: 173.0/255.0, alpha:1.0)
        rightLabel.font = .systemFont(ofSize: 15.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        leftLabel.text = ""
        rightLabel.text = ""
        arrow.alpha = 1
    }
}
