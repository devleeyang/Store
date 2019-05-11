//
//  SearchError.swift
//  Store
//
//  Created by 양혜리 on 11/05/2019.
//  Copyright © 2019 hryang. All rights reserved.
//

import Foundation

enum SearchError: Error {
    case unknown(Error)
    case notFound(String)
    case notDecoder(String)
}

extension SearchError: LocalizedError {
    var localizedDescription: String {
        switch self {
        case let .unknown(error):
            return error.localizedDescription
        case let .notFound(x):
            return x
        case let .notDecoder(x):
            return x
        }
    }
}
