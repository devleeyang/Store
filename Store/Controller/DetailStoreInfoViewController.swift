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
    private var isMore: Bool = false
    private var isDescription: Bool = false
    
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            if isMore {
                return 5
            }
            return 4
        case 1:
            return 1
        case 2:
            return 1
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
            cell.descriptionLabel.text = detailStoreInfo?.releaseNotes
            cell.descriptionLabel.textColor = UIColor(red: 143.0/255.0, green: 143.0/255.0, blue: 143.0/255.0, alpha:1.0)
            cell.descriptionLabel.textAlignment = .left
            cell.descriptionLabel.backgroundColor = UIColor(red: 229.0/255.0, green: 229.0/255.0, blue: 229.0/255.0, alpha:1.0)
            let topView = UIView(frame: CGRect(x: 10, y: 0, width: cell.descriptionLabel.frame.width, height: 10))
            topView.backgroundColor = UIColor(red: 229.0/255.0, green: 229.0/255.0, blue: 229.0/255.0, alpha:1.0)
            cell.addSubview(topView)
            return cell
        case (1,0):
            let cell: DescriptionCell = detailView.dequeueReusableCell(withIdentifier: descriptionCellId, for: indexPath) as! DescriptionCell
            cell.descriptionLabel.text = detailStoreInfo?.description
            if (isDescription) {
                cell.descriptionLabel.numberOfLines = 0
            } else {
                cell.descriptionLabel.numberOfLines = 10
            }
            cell.selectionStyle = .none
            return cell
        case (2,0):
            let cell: CategoryCell = detailView.dequeueReusableCell(withIdentifier: categoryCellId, for: indexPath) as! CategoryCell
            cell.selectionStyle = .none
         
            guard let info = detailStoreInfo else {
                return cell
            }
            inputList.removeAll()
            for text in info.genres {
                let label: CategoryLabel = CategoryLabel()
                label.text = "#\(text)"
                label.sizeToFit()
                label.frame = CGRect(x: label.frame.origin.x, y: label.frame.origin.y, width: label.frame.size.width + 10, height: label.frame.size.height + 10)
                
                if inputList.count == 0 {
                    label.frame.origin = CGPoint(x: 10, y: 0)
                } else {
                    let labelX = inputList[inputList.count - 1].frame.origin.x + inputList[inputList.count - 1].frame.width + 8
                    if (cell.labelViews.frame.size.width < labelX + label.frame.size.width)
                    {
                        label.frame.origin.x = cell.labelViews.frame.origin.x
                        label.frame.origin.y = inputList[inputList.count - 1].frame.origin.y + inputList[inputList.count - 1].frame.height + 8
                    } else {
                        label.frame.origin.x = labelX
                        label.frame.origin.y = inputList[inputList.count - 1].frame.origin.y
                    }
                }
                
                let labelY = label.frame.origin.y + label.frame.size.height + 20
                cell.labelHeight.constant = labelY
                cell.labelViews.updateConstraints()
                cell.labelViews.addSubview(label)
                inputList.append(label)
            }
            
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 3 {
            let cell = detailView.cellForRow(at: indexPath) as! DetailBottomCell
            cell.arrow.isHighlighted = !isMore
            isMore = !isMore
            if isMore {
                detailView.beginUpdates()
                detailView.insertRows(at: [IndexPath(row: 4, section: 0)], with: .none)
                detailView.endUpdates()
            } else {
                detailView.beginUpdates()
                detailView.deleteRows(at: [IndexPath(row: 4, section: 0)], with: .none)
                detailView.endUpdates()
            }
        } else if indexPath.section == 1 && indexPath.row == 0 {
            isDescription = !isDescription
            detailView.reloadRows(at: [indexPath], with: .none)
        }
    }
}

extension DetailStoreInfoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 2) {
            return 20
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if (section == 2) {
            return 20
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if (section == 2) {
            let headerView: UIView = UIView()
            headerView.backgroundColor = UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha:1.0)
            return headerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if (section == 2) {
            let footerView: UIView = UIView()
            footerView.backgroundColor = UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha:1.0)
            return footerView
        }
        return nil
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
