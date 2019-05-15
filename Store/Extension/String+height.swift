//
//  String+height.swift
//  Store
//
//  Created by huraypositive on 15/05/2019.
//  Copyright © 2019 hryang. All rights reserved.
//

import UIKit

extension String {
    func height(withFontSize size: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: UIScreen.main.bounds.width - 20, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: size)], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}
