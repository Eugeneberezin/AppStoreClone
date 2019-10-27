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

class AppsSearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    fileprivate let searchCellID = "SearchCellID"
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    fileprivate let enterSearchTermLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter search term above..."
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: searchCellID)
        collectionView.addSubview(enterSearchTermLabel)
        enterSearchTermLabel.fillSuperview(padding: .init(top: 100, left: 50, bottom: 0, right: 50))
        setupSearchBar()
        
        
    }
    
    fileprivate var appResults = [Result]()
    
    fileprivate func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        
        
    }
    
    var timer: Timer?
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            Service.shared.fetchApps(searchTerm: searchText) { [weak self] (result, err) in
                       if let err = err {
                           print("fail to fetch apps: ", err)
                           return
                       }
                       
                       self?.appResults = result
                              
                              DispatchQueue.main.async {
                                  self?.collectionView.reloadData()
                              }
                   }
        })
        
       
    }
    
   fileprivate func fetchITunesApps() {
    Service.shared.fetchApps(searchTerm: "twitter") { [weak self] (result, err) in
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
        enterSearchTermLabel.isHidden = appResults.count != 0
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
