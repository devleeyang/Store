//
//  ItemList.swift
//  Store
//
//  Created by 양혜리 on 11/09/2019.
//  Copyright © 2019 hryang. All rights reserved.
//

import Foundation

protocol ItemList {
    typealias ItemListLoadedClosure = () -> Void
    associatedtype Item
    associatedtype CellModel
    
    var itemList: [Item]? { get set }
    var cellModelList: [CellModel]? { get set}
    var itemListCount: Int { get }
    
    var didItemListLoaded: ItemListLoadedClosure? { get set }
    var dataLoader: DataLoader { get set }
}

extension ItemList {
    var itemListCount: Int {
        guard let dataList = itemList else {
            return 0
        }
        return dataList.count
    }
}
