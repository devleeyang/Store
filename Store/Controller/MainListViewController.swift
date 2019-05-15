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
    @IBOutlet weak var storeTableView: UITableView!
    private let listCellId = "MainListCell"
    private let searchController = UISearchController(searchResultsController: nil)
    private var storeList = Array<StoreInfo>()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Store"
        searchController.searchBar.delegate = self
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
        } else {
            // Fallback on earlier versions
        }
        
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            // Fallback on earlier versions
        }
        definesPresentationContext = true
        
        storeTableView.register(UINib(nibName: listCellId, bundle: nil), forCellReuseIdentifier: listCellId)
        storeTableView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 0.7430436644)
        storeTableView.separatorColor = .clear
    }
    
    func showErrorMesseage(msg: String) {
        let alertViewController = UIAlertController.init(title: "알림", message: "\(msg)\n잠시 후 다시 시도해주세요", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "확인", style: .default)
        alertViewController.addAction(confirm)
        present(alertViewController, animated: true, completion: nil)
    }
}

extension MainListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MainListCell = storeTableView.dequeueReusableCell(withIdentifier: listCellId, for: indexPath) as! MainListCell
        cell.resultStore = storeList[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailStoreInfoViewController") as? DetailStoreInfoViewController {
            detailViewController.detailStoreInfo = storeList[indexPath.row]
            if let navigator = navigationController {
                let backItem = UIBarButtonItem(title: searchController.searchBar.text, style: .plain, target: nil, action: nil)
                navigationItem.backBarButtonItem = backItem
                navigator.pushViewController(detailViewController, animated: true)
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
        storeTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard
            let searchText = searchController.searchBar.text,
            searchText.count > 0
            else {
                storeList.removeAll()
                storeTableView.reloadData()
                return
        }
        NetworkManager().getStore(query: searchText, onSuccess: { [weak self] in
            self?.storeList = $0
            self?.storeTableView.reloadData()
            }, onFailure: { [weak self] error in
                self?.showErrorMesseage(msg: error.localizedDescription)
        })
    }
}

