//
//  MainListViewController.swift
//  Store
//
//  Created by 양혜리 on 12/05/2019.
//  Copyright © 2019 hryang. All rights reserved.
//

import UIKit
import Kingfisher

class MainStoreListViewController: UIViewController, ViewConfiguration {
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Computed ProPerty
    private lazy var searchController: UISearchController = {
        let searchController: UISearchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "앱 이름 검색"
        searchController.searchBar.delegate = self
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        return searchController
    }()
    
    typealias ViewModelType = MainStoreListViewModel
    var viewModel: MainStoreListViewModel = MainStoreListViewModel()
    
    func configure(by viewModel: MainStoreListViewModel, parameter: [AnyHashable: String]?) {
        viewModel.didItemListLoaded = { [weak self] in
            guard let self = self else {
                return
            }
            self.tableView.reloadData()
        }
        viewModel.loadData(parameter: parameter)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            tableView.tableHeaderView = searchController.searchBar
            searchController.hidesNavigationBarDuringPresentation = false
            navigationController?.navigationBar.isHidden = true
        }
        definesPresentationContext = true
 
        tableView.register(MainStoreListTableViewCell.self)
        tableView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 0.7430436644)
        tableView.separatorColor = .clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard #available(iOS 11.0, *) else {
            tableView.tableHeaderView = searchController.searchBar
            searchController.hidesNavigationBarDuringPresentation = false
            navigationController?.navigationBar.isHidden = true
            return
        }
    
    }
    func showErrorMesseage(msg: String) {
        let alertViewController = UIAlertController.init(title: "알림", message: "\(msg)\n잠시 후 다시 시도해주세요", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "확인", style: .default)
        alertViewController.addAction(confirm)
        present(alertViewController, animated: true, completion: nil)
    }
}


extension MainStoreListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemListCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: MainStoreListTableViewCell.self, for: indexPath) as MainStoreListTableViewCell
     
        cell.cellModel = viewModel.cellModelForRow(at: indexPath.row)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailStoreInfoViewController") as? DetailStoreInfoViewController,
            let store = viewModel.viewModelForRow(at: indexPath.row) {
            detailViewController.detailStoreInfo = StoreInfo(store: store)
            if let navigator = navigationController {
                let backItem = UIBarButtonItem(title: searchController.searchBar.text, style: .plain, target: nil, action: nil)
                navigationItem.backBarButtonItem = backItem
                navigator.pushViewController(detailViewController, animated: true)
            }
        }
    }
}

extension MainStoreListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.width + 115
    }
}

extension MainStoreListViewController : UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let resources = viewModel.cellModelList?.map {
            return ImageResource(downloadURL: $0.iconURL, cacheKey: $0.iconURL.description)
        }
        
        if let imageResources = resources {
            let prefetcher = ImagePrefetcher(resources: imageResources)
            prefetcher.start()
        }
    }
}


extension MainStoreListViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.removeAll()
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard
            let searchText = searchController.searchBar.text,
            searchText.count > 0
            else {
                viewModel.removeAll()
                tableView.reloadData()
                return
        }
        let parameter: [AnyHashable: String] = [ "term": searchText,
                                                 "country": "kr",
                                                 "media": "software" ]
        configure(by: viewModel, parameter: parameter)
    }
}

