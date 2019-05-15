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
        leftLabel.textColor = #colorLiteral(red: 0.1411764706, green: 0.1411764706, blue: 0.1411764706, alpha: 1)
        leftLabel.font = .systemFont(ofSize: 15.0)
        
        rightLabel.textColor = #colorLiteral(red: 0.168627451, green: 0.6509803922, blue: 0.6784313725, alpha: 1)
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
