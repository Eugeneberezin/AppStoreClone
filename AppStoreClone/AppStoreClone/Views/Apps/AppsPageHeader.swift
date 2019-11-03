//
//  AppsPageHeader.swift
//  AppStoreClone
//
//  Created by Eugene Berezin on 11/3/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import Foundation
import UIKit

class AppsPageHeader: UICollectionReusableView, UICollectionViewDelegateFlowLayout {
    
    let appHeaderHorizontalController = AppsHeaderhorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        //appHeaderHorizontalController.view.backgroundColor = .cyan
        addSubview(appHeaderHorizontalController.view)
        appHeaderHorizontalController.view.fillSuperview()
    
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
