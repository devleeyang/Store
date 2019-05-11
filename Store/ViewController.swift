//
//  ViewController.swift
//  Store
//
//  Created by 양혜리 on 11/05/2019.
//  Copyright © 2019 hryang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var storeView: UITableView!
    private let searchController = UISearchController(searchResultsController: nil)
    private var storeList = Array<StoreInfo>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Images"
        searchController.searchBar.delegate = self
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    func showErrorMesseage(msg: String) {
        let alertVC = UIAlertController.init(title: "알림", message: "\(msg)\n잠시 후 다시 시도해주세요", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "확인", style: .default)
        alertVC.addAction(confirm)
        present(alertVC, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell()
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
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
            print(self?.storeList)
            }, onFailure: { [weak self] error in
                self?.showErrorMesseage(msg: error.localizedDescription)
        })
    }
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {

    }
}

