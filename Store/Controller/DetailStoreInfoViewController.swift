//
//  DetailStoreInfoViewController.swift
//  Store
//
//  Created by 양혜리 on 12/05/2019.
//  Copyright © 2019 hryang. All rights reserved.
//

import UIKit
import Kingfisher
import SafariServices

class DetailStoreInfoViewController: UIViewController {

    var detailStoreInfo: StoreInfo?
    private let mainCellId = "DetailMainCell"
    private let collectionCellId = "StoreCollectionCell"
    private let bottomCellId = "DetailBottomCell"
    private let descriptionCellId = "DescriptionCell"
    private let categoryCellId = "CategoryCell"
    private var isMore: Bool = false
    private var isDescription: Bool = false
    private var inputList: Array<CategoryLabel> = Array<CategoryLabel>()
    @IBOutlet weak var detailTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        detailTableView.register(UINib(nibName: mainCellId, bundle: nil), forCellReuseIdentifier: mainCellId)
        detailTableView.register(UINib(nibName: bottomCellId, bundle: nil), forCellReuseIdentifier: bottomCellId)
        detailTableView.register(UINib(nibName: descriptionCellId, bundle: nil), forCellReuseIdentifier: descriptionCellId)
        detailTableView.register(UINib(nibName: categoryCellId, bundle: nil), forCellReuseIdentifier: categoryCellId)
        detailTableView.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        detailTableView.separatorColor = .clear
        detailTableView.bounces = false
    }
    
    @objc func pressedWebButton(_ sender: UIButton) {
        guard
            let urlString = detailStoreInfo?.trackViewUrl,
            let url = URL(string: urlString),
            UIApplication.shared.canOpenURL(url)
            else { return }
        #if TARGET_OS_IPHONE
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        #endif
    }
    
    @objc func pressedShareButton(_ sender: UIButton) {
        if let text = detailStoreInfo?.trackViewUrl {
            let textShare = [text]
            let activityViewController = UIActivityViewController(activityItems: textShare, applicationActivities: nil)
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
    
}

extension DetailStoreInfoViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 5
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
            let cell: DetailMainCell = detailTableView.dequeueReusableCell(withIdentifier: mainCellId, for: indexPath) as! DetailMainCell
            cell.datailStore = detailStoreInfo
            cell.imageCollection.dataSource = self
            cell.imageCollection.register(UINib(nibName: collectionCellId, bundle: nil), forCellWithReuseIdentifier: collectionCellId)
            cell.webBtn.addTarget(self, action: #selector(pressedWebButton), for: .touchUpInside)
            cell.shareBtn.addTarget(self, action: #selector(pressedShareButton), for: .touchUpInside)
            cell.selectionStyle = .none
            return cell
        case (0,1):
            let cell: DetailBottomCell = detailTableView.dequeueReusableCell(withIdentifier: bottomCellId, for: indexPath) as! DetailBottomCell
            cell.leftLabel.text = "크기"
            cell.arrow.alpha = 0
            let convertSize = Int(detailStoreInfo?.fileSizeBytes ?? "0")
            if let size = convertSize {
                let sizeText = size / 1024 / 1024 > 0 ? "\(size / 1024 / 1024)MB" : "\(size / 1024)KB"
                cell.rightLabel.text = sizeText
            }
            cell.selectionStyle = .none
            return cell
        case (0,2):
            let cell: DetailBottomCell = detailTableView.dequeueReusableCell(withIdentifier: bottomCellId, for: indexPath) as! DetailBottomCell
            cell.leftLabel.text = "연령"
            cell.rightLabel.text = (detailStoreInfo?.trackContentRating).map { $0.rawValue }
            cell.arrow.alpha = 0
            cell.selectionStyle = .none
            return cell
        case (0,3):
            let cell: DetailBottomCell = detailTableView.dequeueReusableCell(withIdentifier: bottomCellId, for: indexPath) as! DetailBottomCell
            cell.leftLabel.text = "새로운 기능"
            cell.rightLabel.text = detailStoreInfo?.version
            cell.arrow.isHighlighted = isMore
            cell.selectionStyle = .none
            return cell
        case (0,4):
            let cell: DescriptionCell = detailTableView.dequeueReusableCell(withIdentifier: descriptionCellId, for: indexPath) as! DescriptionCell
            cell.descriptionLabel.text = detailStoreInfo?.releaseNotes
            cell.descriptionLabel.textColor = #colorLiteral(red: 0.5607843137, green: 0.5607843137, blue: 0.5607843137, alpha: 0.74)
            cell.descriptionLabel.textAlignment = .left
            cell.descriptionLabel.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 0.74)
            cell.selectionStyle = .none
//            cell.topView.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 0.74)
//            cell.topView.alpha = 0

            return cell
        case (1,0):
            let cell: DescriptionCell = detailTableView.dequeueReusableCell(withIdentifier: descriptionCellId, for: indexPath) as! DescriptionCell
            cell.descriptionLabel.text = detailStoreInfo?.description
            cell.selectionStyle = .none
            return cell
        case (2,0):
            let cell: CategoryCell = detailTableView.dequeueReusableCell(withIdentifier: categoryCellId, for: indexPath) as! CategoryCell
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
            let cell = detailTableView.cellForRow(at: indexPath) as! DetailBottomCell
            cell.arrow.isHighlighted = !isMore
            isMore = !isMore
//            UIView.setAnimationsEnabled(false)
            detailTableView.beginUpdates()
//            let loc = detailTableView.contentOffset
//            isMore ? detailTableView.reloadRows(at: [IndexPath(row: 4, section: 0)], with: .bottom) : detailTableView.reloadRows(at: [IndexPath(row: 4, section: 0)], with: .top)
            detailTableView.reloadRows(at: [IndexPath(row: 4, section: 0)], with: .none)
//            detailTableView.contentOffset = loc
            detailTableView.endUpdates()
        } else if indexPath.section == 1 && indexPath.row == 0 {
            isDescription = !isDescription
            isDescription ? detailTableView.reloadRows(at: [IndexPath(row: 0, section: 1)], with: .bottom) : detailTableView.reloadRows(at: [IndexPath(row: 0, section: 1)], with: .none)
        }
    }
}

extension DetailStoreInfoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        boundingRectWithSize
        print("hr.yang ---- heightforrow : \(indexPath)")
        guard let storeInfo = detailStoreInfo else {
            return 0
        }
        
        let index = (indexPath.section, indexPath.row)
        switch index {
        case (0,0):
            return storeInfo.sellerName.height(withFontSize: 17) + storeInfo.trackName.height(withFontSize: 21) + 397
        case (0,1),(0,2),(0,3):
            return storeInfo.trackContentRating.rawValue.height(withFontSize: 15) + 20
        case (0,4):
            guard let note = storeInfo.releaseNotes else {
                return CGFloat.leastNonzeroMagnitude
            }
            
            let height = isMore ? note.height(withFontSize: 16) + 26 : CGFloat.leastNonzeroMagnitude
             print("hr.yang ---- height1 : \(height)")
            return height
        case (1,0):
            let a = storeInfo.description.height(withFontSize: 15) + 20
            let b = a > 200 ? 200 : a
            let height = isDescription ? a : b
            print("hr.yang ---- height2 : \(height)")
            return height
        case (2,0):
            return UITableView.automaticDimension
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 2) {
            return 20
        }
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if (section == 2) {
            return 20
        }
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if (section == 2) {
            let headerView: UIView = UIView()
            headerView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 0.74)
            return headerView
        }
        return nil
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if (section == 2) {
            let footerView: UIView = UIView()
            footerView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 0.74)
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
