//
//  CategoryLabel.swift
//  Store
//
//  Created by 양혜리 on 12/05/2019.
//  Copyright © 2019 hryang. All rights reserved.
//

import UIKit

class CategoryLabel: UILabel {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        commonInit()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit(){
        textColor = UIColor(red: 116.0/255.0, green: 116.0/255.0, blue: 116.0/255.0, alpha:1.0)
        font = .systemFont(ofSize: 14.0)
        layer.borderColor = UIColor(red: 216.0/255.0, green: 216.0/255.0, blue: 216.0/255.0, alpha:1.0).cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 4
        numberOfLines = 0
        textAlignment = .center
    }
}
