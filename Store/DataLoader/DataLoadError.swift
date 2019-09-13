//
//  DataLoaderError.swift
//  Store
//
//  Created by 양혜리 on 11/05/2019.
//  Copyright © 2019 hryang. All rights reserved.
//

import Foundation

enum DataLoaderError: Error {
    case unknown
    case urlNotValid(String)
    case alreadyResumedTask(URL?)
    case notResponseData(URLResponse?)
    case failDecode(Error)
    case failure(Error)
    case empty
}

extension DataLoaderError {
    var localizedDescription: String {
        switch self {
        case .unknown:
            return "Unknown"
        case .urlNotValid(let description):
            return description
        case .alreadyResumedTask(let url):
            return url?.description ?? ""
        case .notResponseData(let response):
            return String(describing: response)
        case .failDecode(let error):
            return error.localizedDescription
        case .failure(let error):
            return error.localizedDescription
        case .empty:
            return "Empty Data"
        }
    }
}
