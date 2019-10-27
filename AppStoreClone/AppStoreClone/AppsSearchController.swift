//
//  AppsSearchController.swift
//  AppStoreClone
//
//  Created by Eugene Berezin on 10/26/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class AppsSearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let searchCellID = "SearchCellID"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: searchCellID)
        fetchITunesApps()
        
    }
    
    fileprivate var appResults = [Result]()
    
   fileprivate func fetchITunesApps() {
    Service.shared.fetchApps { [weak self] (result, err) in
        if let err = err {
            print("Failed to fetch data: ", err)
            return
        }
        
        self?.appResults = result
        
        DispatchQueue.main.async {
            self?.collectionView.reloadData()
        }
        
    }
         
       }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: searchCellID, for: indexPath) as! SearchResultCell
        let appResult = appResults[indexPath.item]
        cell.appResult = appResult
        return cell
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 350)
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
