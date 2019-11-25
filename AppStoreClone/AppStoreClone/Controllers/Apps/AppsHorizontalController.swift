//
//  AppsHorizontalController.swift
//  AppStoreClone
//
//  Created by Eugene Berezin on 11/3/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class AppsHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
    private let hCellID = "Horizontal cell id"
    
    var appGroudp: AppGroup?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(AppRowCell.self, forCellWithReuseIdentifier: hCellID)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appGroudp?.feed.results.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: hCellID, for: indexPath) as! AppRowCell
        cell.nameLabel.text = appGroudp?.feed.results[indexPath.item].name
        cell.companyLabel.text = appGroudp?.feed.results[indexPath.item].artistName
        cell.imageView.sd_setImage(with: URL(string: appGroudp?.feed.results[indexPath.item].artworkUrl100 ?? ""))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.height - 12 - 12 - 20) / 3
        return .init(width: view.frame.width - 48, height: height )
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
