//
//  SearchError.swift
//  Store
//
//  Created by 양혜리 on 11/05/2019.
//  Copyright © 2019 hryang. All rights reserved.
//

import Foundation

enum SearchError: Error {
    case unknown
    case empty
    case notResponseData
    case failure(Error)
}

extension SearchError {
    var localizedDescription: String {
        switch self {
        case .unknown:
            return "Unknown"
        case .empty:
            return "Store List is Empty"
        case .notResponseData:
            return "Not Response Data"
        case .failure(let error):
            return error.localizedDescription
        }
    }
}
