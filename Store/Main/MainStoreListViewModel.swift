//
//  MainStoreListViewModel.swift
//  Store
//
//  Created by 양혜리 on 11/09/2019.
//  Copyright © 2019 hryang. All rights reserved.
//

import Foundation

class MainStoreListViewModel: ItemList {
    typealias Item = Store
    typealias CellModel = MainStoreCellModel
    
    var didItemListLoaded: ItemListLoadedClosure?
    var dataLoader: DataLoader
    var itemList: [Store]?
    
    var cellModelList: [MainStoreCellModel]? {
        didSet {
            didItemListLoaded?()
        }
    }
    
    init(loader: DataLoader = APILoader()) {
        self.dataLoader = loader
    }
    
    func cellModelForRow(at row: Int) -> MainStoreCellModel? {
        return cellModelList?[row]
    }
    
    func viewModelForRow(at row: Int) -> Store? {
        return itemList?[row]
    }
    
    func removeAll() {
        cellModelList?.removeAll()
        itemList?.removeAll()
    }
    
    // MARK: - Load Data
    private func received(_ result: Result<StoreListResponse, Error>) {
        switch result {
        case .success(let response):
            itemList = response.stores
            cellModelList = response.stores.map { store in
                return MainStoreCellModel(store: store)
            }
        case .failure(let error):
            print(" Error: \(error)")
        }
    }
    
    func loadData(parameter: [AnyHashable: String]? = nil) {
        dataLoader.load(by: StoreAPIRouter.searchStoreList(parameter)) { [weak self] (result: Result<StoreListResponse, Error>) in
            guard let self = self else {
                return
            }
            self.received(result)
        }
    }
}
