//
//  AppsController.swift
//  AppStoreClone
//
//  Created by Eugene Berezin on 11/3/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import Foundation
import UIKit

class AppsPageController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellID = "AppsCellID"
    let headerID = "AppHeaderID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: cellID)
        //1 Register supplementaryViewOfKind
        collectionView.register(AppsPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
        fetchData()
        
    }
    
     var socialApps = [SocialApp]()
     var groups = [AppGroup]()
       
       fileprivate func fetchData() {
           
           var group1: AppGroup?
           var group2: AppGroup?
           var group3: AppGroup?
           
           // help you sync your data fetches together
           let dispatchGroup = DispatchGroup()
           
           dispatchGroup.enter()
           Service.shared.fetchGames { (appGroup, err) in
               print("Done with games")
               dispatchGroup.leave()
               group1 = appGroup
           }
           
           dispatchGroup.enter()
           Service.shared.fetchTopGrossing { (appGroup, err) in
               print("Done with top grossing")
               dispatchGroup.leave()
               group2 = appGroup
           }
           
           dispatchGroup.enter()
           Service.shared.fetchAppGroup(urlString: "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/25/explicit.json") { (appGroup, err) in
               dispatchGroup.leave()
               print("Done with free games")
               group3 = appGroup
           }
        
        Service.shared.fetchSocialApps { (apps, err) in
            if let err = err {
                print(err)
                return
            }
            self.socialApps = apps ?? []
            
            
            
        }
           
           // completion
           dispatchGroup.notify(queue: .main) {
               print("completed your dispatch group tasks...")
               
               if let group = group1 {
                   self.groups.append(group)
               }
               if let group = group2 {
                   self.groups.append(group)
               }
               if let group = group3 {
                   self.groups.append(group)
               }
               self.collectionView.reloadData()
           }
       }
    
    //2
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as! AppsPageHeader
        header.appHeaderHorizontalController.socialApps = self.socialApps
        header.appHeaderHorizontalController.collectionView.reloadData()
    
    
        return header
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! AppsGroupCell
        let appGroup = groups[indexPath.item]
        cell.titleLabel.text = appGroup.feed.title
        cell.horizontalController.appGroudp = appGroup
        cell.horizontalController.collectionView.reloadData()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
    init() {
           super.init(collectionViewLayout: UICollectionViewFlowLayout())
       }
       
       required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    
}
