//
//  BaseListController.swift
//  AppStoreClone
//
//  Created by Eugene Berezin on 11/3/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import Foundation
import UIKit

class BaseListController: UICollectionViewController {
    init() {
              super.init(collectionViewLayout: UICollectionViewFlowLayout())
          }
          
          required init?(coder aDecoder: NSCoder) {
              fatalError("init(coder:) has not been implemented")
          }
    
}
