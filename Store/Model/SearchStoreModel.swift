//
//  SearchStoreModel.swift
//  Store
//
//  Created by 양혜리 on 11/05/2019.
//  Copyright © 2019 hryang. All rights reserved.
//

import Foundation

struct SearchStoreModel: Codable {
    let resultCount: Int
    let results: [Results]
}

struct Results: Codable {
    let screenshotUrls: [String]
    let artworkUrl512: String
    let trackViewURL: String
    let fileSizeBytes: String
    let trackContentRating: Rating
    let trackName: String
    let sellerName: String
    let version, description: String
    let genres: [String]
    let price: Int
    let formattedPrice: FormattedPrice
    let releaseNotes: String?
    let averageUserRating: Double?
    
    enum CodingKeys: String, CodingKey {
        case screenshotUrls
        case artworkUrl512
        case trackViewURL = "trackViewUrl"
        case fileSizeBytes, trackContentRating
        case trackName
        case sellerName, version, description
        case genres, price
        case formattedPrice, releaseNotes, averageUserRating
    }
}

enum Rating: String, Codable {
    case the12 = "12+"
    case the17 = "17+"
    case the9 = "9+"
    case the4 = "4+"
}

enum FormattedPrice: String, Codable {
    case the5900 = "￦5,900"
    case theFree = "무료"
}

struct StoreInfo {
    let screenshotUrls: [String]
    let trackViewUrl: String
    let description: String
    let trackName: String
    let formattedPrice: FormattedPrice
    let genres: [String]
    let trackContentRating: Rating
    let sellerName: String
    let releaseNotes: String?
    let version: String
    let averageUserRating: Double?
    let price: Int
    let fileSizeBytes: String
    let artworkUrl512: String
}
