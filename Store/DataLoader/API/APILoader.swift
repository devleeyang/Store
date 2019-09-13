//
//  APILoader.swift
//  Store
//
//  Created by 양혜리 on 11/09/2019.
//  Copyright © 2019 hryang. All rights reserved.
//

import Foundation

class APILoader: DataLoader {
    private var taskQueue: [URLSessionDataTask] = []
    
    func load<T: Codable>(by router: APIRouter, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let urlRequest = URLRequest(router: router) else {
            completion(.failure(DataLoaderError.urlNotValid("Reauset URL is not Validation")))
            return
        }
        let isAlreadyResumed = taskQueue.contains { dataTask -> Bool in
            return dataTask.originalRequest?.url == urlRequest.url
        }
        guard !isAlreadyResumed else {
            completion(.failure(DataLoaderError.alreadyResumedTask(urlRequest.url)))
            return
        }
        print("urlRequest: \(urlRequest)")
        
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let self = self else {
                return
            }
            self.taskQueue.removeAll { dataTask -> Bool in
                return dataTask.originalRequest?.url == response?.url
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(DataLoaderError.notResponseData(response)))
                }
                return
            }
            do {
                let parsedResponse = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(parsedResponse))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(DataLoaderError.failDecode(error)))
                }
            }
        }
        taskQueue.append(task)
        task.resume()
    }
}
