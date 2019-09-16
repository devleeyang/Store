//
//  CategoryCell.swift
//  Store
//
//  Created by 양혜리 on 12/05/2019.
//  Copyright © 2019 hryang. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {

    @IBOutlet weak var categoryCollectionCell: UICollectionView!
    var genres: [String] = [String]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        categoryCollectionCell.register(CategoryLabelCell.self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

extension CategoryCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("genres: \(genres.count)")
        return genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("collectionView1: \(collectionView)")
        let cell = collectionView.dequeueReusableCell(withClass: CategoryLabelCell.self, for: indexPath) as CategoryLabelCell
        cell.categoryLabel.text = genres[indexPath.row]
        return cell
    }
}
