//
//  Register+ColletionView.swift
//  Store
//
//  Created by 양혜리 on 10/09/2019.
//  Copyright © 2019 hryang. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_ cell: T.Type) {
        
        let nib = UINib(nibName: String(describing: cell), bundle: nil)
        register(nib, forCellWithReuseIdentifier: String(describing: cell))
    }
    
    func registers<T: UICollectionViewCell>(_ classes: [T.Type]) {
        classes.forEach {
            let nib = UINib(nibName: String(describing: $0), bundle: nil)
            register(nib, forCellWithReuseIdentifier: String(describing: $0))
        }
        
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(withClass name: T.Type, for indexPath: IndexPath) ->  T  {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: name), for: indexPath) as? T else {
            fatalError("Couldn't find UITableViewCell for \(String(describing: name))")
        }
        return cell
    }
}
