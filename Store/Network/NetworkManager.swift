//
//  NetworkManager.swift
//  Store
//
//  Created by 양혜리 on 11/05/2019.
//  Copyright © 2019 hryang. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    func getStore(query: String, onSuccess: @escaping ([StoreInfo]) -> Void, onFailure: @escaping (SearchError) -> Void) {
        if let encodeString = query.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed) {
            get(path: "search?term=\(encodeString)&country=kr&media=software", onSuccess: { (data) in
                do {
                    let response = try JSONDecoder().decode(SearchStoreModel.self, from: data)
                    let storeList = response.results.map { store -> StoreInfo in
                        return StoreInfo(screenshotUrls: store.screenshotUrls, trackViewUrl: store.trackViewURL, description: store.description, trackName: store.trackName, formattedPrice: store.formattedPrice, genres: store.genres, trackContentRating: store.trackContentRating, sellerName: store.sellerName, releaseNotes: store.releaseNotes, version: store.version, averageUserRating: store.averageUserRating, price: store.price, fileSizeBytes: store.fileSizeBytes, artworkUrl512: store.artworkUrl512)
                    }
                    
                    if storeList.count > 0 {
                        onSuccess(storeList)
                    } else {
                        onFailure(.empty)
                    }
                } catch {
                    onFailure(.failure(error))
                }
            }, onFailure: {
                onFailure($0)
            })
        }
    }
    
    private func get(path: String, onSuccess: @escaping (Data) -> Void, onFailure: @escaping (SearchError) -> Void) {
        Alamofire.request("https://itunes.apple.com/\(path)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON {
            guard let data = $0.data else {
                onFailure(.notResponseData)
                return
            }
            
            switch $0.result {
            case .success:
                onSuccess(data)
            case .failure:
                if let error = $0.error {
                    onFailure(.failure(error))
                } else {
                    onFailure(.unknown)
                }
            }
        }
    }
}
