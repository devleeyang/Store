//
//  MainStoreCellModel.swift
//  Store
//
//  Created by 양혜리 on 13/09/2019.
//  Copyright © 2019 hryang. All rights reserved.
//

import Foundation

struct MainStoreCellModel {
    let name: String
    let averageRating: Double
    let company: String
    let price: String
    let category: String
    let iconURL: URL
    
    init(store: Store) {
        self.name = store.trackName
        self.averageRating = store.averageUserRating ?? 0.0
        self.company = store.sellerName
        self.category = store.genres.first ?? ""
        self.price = store.formattedPrice.rawValue
        self.iconURL = URL(string: store.artworkUrl512)!
    }
}
