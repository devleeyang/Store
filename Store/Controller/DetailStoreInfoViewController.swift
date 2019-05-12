//
//  DetailStoreInfoViewController.swift
//  Store
//
//  Created by 양혜리 on 12/05/2019.
//  Copyright © 2019 hryang. All rights reserved.
//

import UIKit
import Kingfisher

class DetailStoreInfoViewController: UIViewController {

    var detailStoreInfo: StoreInfo?
    private let mainCellId = "DetailMainCell"
    private let collectionCellId = "StoreCollectionCell"
    private let bottomCellId = "DetailBottomCell"
    private let descriptionCellId = "DescriptionCell"
    private let categoryCellId = "CategoryCell"
    
    @IBOutlet weak var detailView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailView.register(UINib(nibName: mainCellId, bundle: nil), forCellReuseIdentifier: mainCellId)
        detailView.register(UINib(nibName: bottomCellId, bundle: nil), forCellReuseIdentifier: bottomCellId)
        detailView.register(UINib(nibName: descriptionCellId, bundle: nil), forCellReuseIdentifier: descriptionCellId)
        detailView.register(UINib(nibName: categoryCellId, bundle: nil), forCellReuseIdentifier: categoryCellId)
        detailView.backgroundColor = UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha:1.0)
        detailView.separatorColor = .clear
    }
    
}

extension DetailStoreInfoViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 6
        case 1:
            return 2
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let index = (indexPath.section, indexPath.row)
        switch index {
        case (0,0):
            let cell: DetailMainCell = detailView.dequeueReusableCell(withIdentifier: mainCellId, for: indexPath) as! DetailMainCell
            cell.datailStore = detailStoreInfo
            cell.imageCollection.dataSource = self
            cell.imageCollection.register(UINib(nibName: collectionCellId, bundle: nil), forCellWithReuseIdentifier: collectionCellId)
            cell.selectionStyle = .none
            return cell
        case (0,1):
            let cell: DetailBottomCell = detailView.dequeueReusableCell(withIdentifier: bottomCellId, for: indexPath) as! DetailBottomCell
            cell.leftLabel.text = "크기"
            cell.arrow.alpha = 0
            cell.rightLabel.text = detailStoreInfo?.fileSizeBytes
            cell.selectionStyle = .none
            return cell
        case (0,2):
            let cell: DetailBottomCell = detailView.dequeueReusableCell(withIdentifier: bottomCellId, for: indexPath) as! DetailBottomCell
            cell.leftLabel.text = "연령"
            cell.rightLabel.text = (detailStoreInfo?.trackContentRating).map { $0.rawValue }
            cell.arrow.alpha = 0
            cell.selectionStyle = .none
            return cell
        case (0,3):
            let cell: DetailBottomCell = detailView.dequeueReusableCell(withIdentifier: bottomCellId, for: indexPath) as! DetailBottomCell
            cell.leftLabel.text = "새로운 기능"
            cell.rightLabel.text = detailStoreInfo?.version
            cell.selectionStyle = .none
            return cell
        case (0,4):
            let cell: DescriptionCell = detailView.dequeueReusableCell(withIdentifier: descriptionCellId, for: indexPath) as! DescriptionCell
            cell.descriptionLabel.text = detailStoreInfo?.description
            cell.selectionStyle = .none
            return cell
        case (1,0):
            let cell: CategoryCell = detailView.dequeueReusableCell(withIdentifier: categoryCellId, for: indexPath) as! CategoryCell
            cell.selectionStyle = .none
         
            guard let info = detailStoreInfo,
                cell.labelStackView.subviews.count == 0 else {
                return cell
            }
            
            for text in info.genres {
                let label: CategoryLabel = CategoryLabel()
                label.text = text
                cell.labelStackView.addArrangedSubview(label)
            }
            return cell
        default:
            let cell = UITableViewCell(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 10))
            cell.backgroundColor = UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha:1.0)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 3 {
            detailView.reloadRows(at: [indexPath], with: .bottom)
        }
    }
}

extension DetailStoreInfoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension DetailStoreInfoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailStoreInfo?.screenshotUrls.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellId, for: indexPath) as! StoreCollectionCell
        let resource = ImageResource(downloadURL: URL(string: detailStoreInfo?.screenshotUrls[indexPath.row] ?? "")!, cacheKey: detailStoreInfo?.screenshotUrls[indexPath.row])
        cell.storeImageView.kf.setImage(with: resource)
        return cell
    }
}
