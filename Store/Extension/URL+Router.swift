//
//  URL+Router.swift
//  Store
//
//  Created by 양혜리 on 11/09/2019.
//  Copyright © 2019 hryang. All rights reserved.
//

import Foundation

extension URLQueryItem {
    static func items(with rawItems: [AnyHashable: String?]?) -> [URLQueryItem]? {
        guard let parameters = rawItems else {
            return nil
        }
        return parameters.compactMap { parameter -> URLQueryItem? in
            guard let value = parameter.value,
                let name = parameter.key as? String else {
                    return nil
            }
            return URLQueryItem(name: name, value: value)
        }
    }
}

extension URLRequest {
    init?(router: APIRouter) {
        var urlComponents = URLComponents()
        urlComponents.scheme = router.scheme
        urlComponents.host = router.host
        urlComponents.path = router.path
        urlComponents.queryItems = router.queryItems
        guard let url = urlComponents.url else {
            return nil
        }
        self.init(url: url)
        self.httpMethod = router.method.rawValue
        self.allHTTPHeaderFields = router.allHTTPHeaderFields
    }
}
