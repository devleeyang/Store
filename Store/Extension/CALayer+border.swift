//
//  CALayer+border.swift
//  Store
//
//  Created by huraypositive on 13/05/2019.
//  Copyright © 2019 hryang. All rights reserved.
//

import UIKit

extension CALayer {
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
        case .top:
            border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: thickness)
            break
        case .bottom:
            border.frame = CGRect(x: 0, y: frame.size.height - thickness, width: frame.size.width, height: thickness)
            break
        case .left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: frame.size.height)
            break
        case .right:
            border.frame = CGRect(x: frame.size.width - thickness, y: 0, width: thickness, height: frame.size.height)
            break
        default:
            break
        }
        
        border.backgroundColor = color.cgColor;
        addSublayer(border)
    }
}
