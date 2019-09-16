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
    private let collectionCellId = "StoreCollectionCell"
    private var isMore: Bool = false
    private var isDescription: Bool = false
    private var inputList: [CategoryLabel] = [CategoryLabel]()
    private var heightDictionary: [IndexPath: CGFloat] = [IndexPath: CGFloat]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let cellTypes: [UITableViewCell.Type] = [ DetailMainCell.self,
                  DetailBottomCell.self,
                  DescriptionCell.self,
                  CategoryCell.self ]
        
        tableView.registers(cellTypes)
        tableView.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        tableView.separatorColor = .clear
        tableView.estimatedRowHeight = 400.0

        guard #available(iOS 11.0, *) else {
            navigationController?.navigationBar.isHidden = false
            return
        }
    }
    
    @objc func pressedWebButton(_ sender: UIButton) {
        guard
            let urlString = detailStoreInfo?.trackViewUrl,
            let url = URL(string: urlString),
            UIApplication.shared.canOpenURL(url)
            else { return }
        #if TARGET_OS_SIMULATOR
        #else
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
            let count = isMore ? 5 : 4
            return count
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
            let cell = tableView.dequeueReusableCell(withClass: DetailMainCell.self, for: indexPath) as DetailMainCell
            cell.datailStore = detailStoreInfo
            cell.imageCollection.dataSource = self
            cell.imageCollection.register(StoreCollectionCell.self)
            cell.webBtn.addTarget(self, action: #selector(pressedWebButton), for: .touchUpInside)
            cell.shareBtn.addTarget(self, action: #selector(pressedShareButton), for: .touchUpInside)
            cell.selectionStyle = .none
            return cell
        case (0,1):
            let cell = tableView.dequeueReusableCell(withClass: DetailBottomCell.self, for: indexPath) as DetailBottomCell
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
            let cell = tableView.dequeueReusableCell(withClass: DetailBottomCell.self, for: indexPath) as DetailBottomCell
            cell.leftLabel.text = "연령"
            cell.rightLabel.text = (detailStoreInfo?.trackContentRating).map { $0.rawValue }
            cell.arrow.alpha = 0
            cell.selectionStyle = .none
            return cell
        case (0,3):
            let cell = tableView.dequeueReusableCell(withClass: DetailBottomCell.self, for: indexPath) as DetailBottomCell
            cell.leftLabel.text = "새로운 기능"
            cell.rightLabel.text = detailStoreInfo?.version
            cell.arrow.isHighlighted = isMore
            cell.selectionStyle = .none
            return cell
        case (0,4):
            let cell = tableView.dequeueReusableCell(withClass: DescriptionCell.self, for: indexPath) as DescriptionCell
            cell.descriptionLabel.text = detailStoreInfo?.releaseNotes
            cell.descriptionLabel.textColor = #colorLiteral(red: 0.5607843137, green: 0.5607843137, blue: 0.5607843137, alpha: 0.74)
            cell.descriptionLabel.textAlignment = .left
            cell.descriptionLabel.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 0.74)
            cell.selectionStyle = .none

            return cell
        case (1,0):
            let cell = tableView.dequeueReusableCell(withClass: DescriptionCell.self, for: indexPath) as DescriptionCell
            cell.descriptionLabel.text = detailStoreInfo?.description
            cell.selectionStyle = .none
            return cell
        case (2,0):
            let cell = tableView.dequeueReusableCell(withClass: CategoryCell.self, for: indexPath) as CategoryCell
            cell.selectionStyle = .none
         
            guard let info = detailStoreInfo else {
                return cell
            }
            cell.genres = info.genres
            
//            inputList.removeAll()
//            for text in info.genres {
//                let label: CategoryLabel = CategoryLabel()
//                label.text = "#\(text)"
//                label.sizeToFit()
//                label.frame = CGRect(x: label.frame.origin.x, y: label.frame.origin.y, width: label.frame.size.width + 10, height: label.frame.size.height + 10)
//
//                if inputList.count == 0 {
//                    label.frame.origin = CGPoint(x: 10, y: 0)
//                } else {
//                    let labelX = inputList[inputList.count - 1].frame.origin.x + inputList[inputList.count - 1].frame.width + 8
//                    if (cell.labelViews.frame.size.width < labelX + label.frame.size.width)
//                    {
//                        label.frame.origin.x = cell.labelViews.frame.origin.x
//                        label.frame.origin.y = inputList[inputList.count - 1].frame.origin.y + inputList[inputList.count - 1].frame.height + 8
//                    } else {
//                        label.frame.origin.x = labelX
//                        label.frame.origin.y = inputList[inputList.count - 1].frame.origin.y
//                    }
//                }
//
//                let labelY = label.frame.origin.y + label.frame.size.height + 20
//                cell.labelHeight.constant = labelY
//                cell.labelViews.updateConstraints()
//                cell.labelViews.addSubview(label)
//                inputList.append(label)
//            }
            
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let loc = tableView.contentOffset
        if indexPath.section == 0 && indexPath.row == 3 {
            guard
                let storeInfo = detailStoreInfo,
                let _ = storeInfo.releaseNotes else {
                return
            }
            
            let cell = tableView.cellForRow(at: indexPath) as! DetailBottomCell
            cell.arrow.isHighlighted = !isMore
            isMore = !isMore
            tableView.beginUpdates()
            if isMore {
                tableView.insertRows(at: [IndexPath(row: 4, section: 0)], with: .top)
            } else {
                tableView.deleteRows(at: [IndexPath(row: 4, section: 0)], with: .top)
            }
            tableView.endUpdates()
            
        } else if indexPath.section == 1 && indexPath.row == 0 {
            isDescription = !isDescription
            tableView.beginUpdates()
            tableView.reloadRows(at: [IndexPath(row: 0, section: 1)], with: .none)
            tableView.endUpdates()
        }
        tableView.contentOffset = loc
    }
}

extension DetailStoreInfoViewController: UITableViewDelegate {
    /*
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
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
                return 0
            }

            let height = isMore ? note.height(withFontSize: 16) + 26 : 0
            return height
        case (1,0):
            let minHeight = storeInfo.description.height(withFontSize: 15) + 20
            let finalHeight = minHeight > 200 ? 200 : minHeight
            let height = isDescription ? minHeight : finalHeight
            return height
        case (2,0):
            return  100.0
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
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
                return 0
            }

            let height = isMore ? note.height(withFontSize: 16) + 26 : 0
            return height
        case (1,0):
            let minHeight = storeInfo.description.height(withFontSize: 15) + 20
            let finalHeight = minHeight > 200 ? 200 : minHeight
            let height = isDescription ? minHeight : finalHeight
            return height
        case (2,0):
            return 100.0
        default:
            return UITableView.automaticDimension
        }
    }
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard detailStoreInfo != nil else {
            return 0
        }
        
        if let height = heightDictionary[indexPath] {
            return height
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let height = cell.frame.size.height.native
        heightDictionary.updateValue(CGFloat(height), forKey: indexPath)
    }


    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if (section == 2) {
//            return 20
//        }
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        if (section == 2) {
//            return 20
//        }
        return CGFloat.leastNonzeroMagnitude
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        if (section == 2) {
//            let headerView: UIView = UIView()
//            headerView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 0.74)
//            return headerView
//        }
//        return nil
//    }
//
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        if (section == 2) {
//            let footerView: UIView = UIView()
//            footerView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 0.74)
//            return footerView
//        }
//        return nil
//    }
}

extension DetailStoreInfoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailStoreInfo?.screenshotUrls.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("collectionView: \(collectionView)")
        let cell = collectionView.dequeueReusableCell(withClass: StoreCollectionCell.self, for: indexPath) as StoreCollectionCell
        let resource = ImageResource(downloadURL: URL(string: detailStoreInfo?.screenshotUrls[indexPath.row] ?? "")!, cacheKey: detailStoreInfo?.screenshotUrls[indexPath.row])
        cell.storeImageView.kf.setImage(with: resource)
        return cell
    }
}
