//
//  UIView+Round.swift
//  Store
//
//  Created by 양혜리 on 12/05/2019.
//  Copyright © 2019 hryang. All rights reserved.
//

import UIKit

extension UIView {
    func roundedCorners(top: Bool){
        let corners:UIRectCorner = (top ? [.topLeft , .topRight] : [.bottomRight , .bottomLeft])
        let maskPAth1 = UIBezierPath(roundedRect:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 20, height: UIScreen.main.bounds.size.width - 20),
                                     byRoundingCorners: corners,
                                     cornerRadii:CGSize(width:4.0, height:4.0))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = self.bounds
        maskLayer1.path = maskPAth1.cgPath
        self.layer.mask = maskLayer1
    }
    
    func roundedCorners(left: Bool){
        let corners:UIRectCorner = (left ? [.topLeft , .bottomLeft] : [.topRight , .bottomRight])
        let maskPAth1 = UIBezierPath(roundedRect:self.bounds,
                                     byRoundingCorners: corners,
                                     cornerRadii:CGSize(width:4.0, height:4.0))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = self.bounds
        maskLayer1.path = maskPAth1.cgPath
        self.layer.mask = maskLayer1
    }
}
