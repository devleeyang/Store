//
//  DataLoader.swift
//  Store
//
//  Created by 양혜리 on 11/09/2019.
//  Copyright © 2019 hryang. All rights reserved.
//

import Foundation

protocol DataLoader {
    func load<T: Codable>(by router: APIRouter, completion: @escaping (Result<T, Error>) -> Void)
}
