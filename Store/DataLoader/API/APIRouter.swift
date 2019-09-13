//
//  APIRouter.swift
//  Store
//
//  Created by 양혜리 on 11/09/2019.
//  Copyright © 2019 hryang. All rights reserved.
//

import Foundation

protocol APIRouter {
    var method: HTTPMethod { get }
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
    var allHTTPHeaderFields: [String: String]? { get }
}
