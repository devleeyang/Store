//
//  Register+TableView.swift
//  Store
//
//  Created by 양혜리 on 07/09/2019.
//  Copyright © 2019 hryang. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register<T: UITableViewCell>(_ cell: T.Type) {
        
        let nib = UINib(nibName: String(describing: cell), bundle: nil)
        register(nib, forCellReuseIdentifier: String(describing: cell))
    }
    
    func registers<T: UITableViewCell>(_ classes: [T.Type]) {
        classes.forEach {
            let nib = UINib(nibName: String(describing: $0), bundle: nil)
            register(nib, forCellReuseIdentifier: String(describing: $0))
        }
    
    }
    
    func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: name), for: indexPath) as? T else {
            fatalError("Couldn't find UITableViewCell for \(String(describing: name))")
        }
        return cell
    }
}
