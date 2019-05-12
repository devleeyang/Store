//
//  DetailStoreInfoViewController.swift
//  Store
//
//  Created by 양혜리 on 12/05/2019.
//  Copyright © 2019 hryang. All rights reserved.
//

import UIKit

class DetailStoreInfoViewController: UIViewController {

    var detailStoreInfo: StoreInfo?
    private let mainCellId = "DetailMainCell"
    @IBOutlet weak var detailView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailView.register(UINib(nibName: mainCellId, bundle: nil), forCellReuseIdentifier: mainCellId)
        detailView.backgroundColor = .white
        detailView.separatorColor = .clear
    }
    
}

extension DetailStoreInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DetailMainCell = detailView.dequeueReusableCell(withIdentifier: mainCellId, for: indexPath) as! DetailMainCell
        cell.datailStore = detailStoreInfo
        cell.selectionStyle = .none
        return cell
    }
}

extension DetailStoreInfoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 530.0
    }
}

