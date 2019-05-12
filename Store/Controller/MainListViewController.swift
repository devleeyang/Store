//
//  MainListViewController.swift
//  Store
//
//  Created by 양혜리 on 12/05/2019.
//  Copyright © 2019 hryang. All rights reserved.
//

import UIKit
import Kingfisher

class MainListViewController: UIViewController {
    @IBOutlet weak var storeView: UITableView!
    private let listCellId = "MainListCell"
    private let searchController = UISearchController(searchResultsController: nil)
    private var storeList = Array<StoreInfo>()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Store"
        searchController.searchBar.delegate = self
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        
        storeView.register(UINib(nibName: listCellId, bundle: nil), forCellReuseIdentifier: listCellId)
        storeView.backgroundColor = UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha:1.0)
        storeView.separatorColor = .clear
    }
    
    func showErrorMesseage(msg: String) {
        let alertVC = UIAlertController.init(title: "알림", message: "\(msg)\n잠시 후 다시 시도해주세요", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "확인", style: .default)
        alertVC.addAction(confirm)
        present(alertVC, animated: true, completion: nil)
    }
}

extension MainListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MainListCell = storeView.dequeueReusableCell(withIdentifier: listCellId, for: indexPath) as! MainListCell
        cell.resultStore = storeList[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailStoreInfoViewController") as? DetailStoreInfoViewController {
            detailVC.detailStoreInfo = storeList[indexPath.row]
            if let navigator = navigationController {
                navigator.pushViewController(detailVC, animated: true)
            }
        }
    }
}

extension MainListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.width + 115
    }
}

extension MainListViewController : UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let resources = storeList.map {
            return ImageResource(downloadURL: URL(string: $0.artworkUrl512)!, cacheKey: $0.artworkUrl512)
        }
        let prefetcher = ImagePrefetcher(resources: resources)
        prefetcher.start()
    }
}


extension MainListViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        storeList.removeAll()
        storeView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard
            let searchText = searchController.searchBar.text,
            searchText.count > 0
            else {
                storeList.removeAll()
                storeView.reloadData()
                return
        }
        NetworkManager().getStore(query: searchText, onSuccess: { [weak self] in
            self?.storeList = $0
            self?.storeView.reloadData()
            }, onFailure: { [weak self] error in
                self?.showErrorMesseage(msg: error.localizedDescription)
        })
    }
}

